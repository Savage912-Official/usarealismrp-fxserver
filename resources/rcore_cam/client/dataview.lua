--[[
    A DataView implementation based on LUAGLM_EXT_BLOB

API:
    -- Creates a new ArrayBuffer object.
    DataView.ArrayBuffer(byteCount)

    -- Returns a value according to <Type>. An optional 'offset' marks where
    -- to start reading within the DataView buffer. Note, all offsets are zero
    -- based.
    --
    -- Available Functions:
    --  DataView.GetInt8  DataView.GetUint8
    --  DataView.GetInt16 DataView.GetUint16
    --  DataView.GetInt32 DataView.GetUint32
    --  DataView.GetInt64 DataView.GetUint64
    --  DataView.GetFloat32 DataView.GetFloat64
    --  DataView.GetString
    --  DataView.GetLuaInt -- Extension: A lua_Integer
    --  DataView.GetUluaInt -- Extension: A lua_Unsigned
    --  DataView.GetLuaNum -- Extension: lua_Number
    --  DataView.GetAddress -- Extension: %p (@Unsafe; Requires d37b6655f)
    DataView.Get<Type>(self, offset [, bigEndian])

    -- Serialize in binary form (string.pack) a 'value' according to <Type>
    --
    -- Available Functions:
    --  DataView.SetInt8 DataView.SetUint8
    --  DataView.SetInt16 DataView.SetUint16
    --  DataView.SetInt32 DataView.SetUint32
    --  DataView.SetInt64 DataView.SetUint64
    --  DataView.SetFloat32 DataView.SetFloat64
    --  DataView.SetString
    --  DataView.SetLuaInt -- Extension: A lua_Integer
    --  DataView.SetUluaInt -- Extension: A lua_Unsigned
    --  DataView.SetLuaNum -- Extension: lua_Number
    --  DataView.SetAddress -- Extension: %p (@Unsafe; Requires d37b6655f)
    DataView.Set<Type>(self, offset, value [, bigEndian])

    -- Return a value according to <Type> and a dynamic type-length.
    --
    -- Available Functions:
    --  DataView.GetFixedInt
    --  DataView.GetFixedUint
    --  DataView.GetFixedString
    DataView.GetFixed<Type>(self, offset, type_length [, bigEndian])

    -- Serialize in binary form a 'value' according to <Type> and a dynamic
    -- type-length.
    --
    -- Available Functions:
    --  DataView.SetFixedInt
    --  DataView.SetFixedUint
    --  DataView.SetFixedString
    DataView.SetFixed<Type>(self, offset, type_length, value [, bigEndian])

@NOTES:
      (1) Endianness changed from JS API: defaults to little endian.

@EXAMPLES:
    -- GET_DLC_WEAPON_DATA
    local view = DataView.ArrayBuffer(512)
    if Citizen.InvokeNative(0x79923CD21BECE14E, 1, view:Buffer(), Citizen.ReturnResultAnyway()) then
        local dlc = {
            validCheck = view:GetInt64(0),
            weaponHash = view:GetInt32(8),
            val3 = view:GetInt64(16),
            weaponCost = view:GetInt64(24),
            ammoCost = view:GetInt64(32),
            ammoType = view:GetInt64(40),
            defaultClipSize = view:GetInt64(48),
            nameLabel = view:GetString(56),-- \0 delimited natively
            descLabel = view:GetString(120), -- \0 delimited natively
            simpleDesc = view:GetString(184), -- \0 delimited natively
            upperCaseName = view:GetString(248), -- \0 delimited natively
        }

        -- Output: print(json.encode(dlc, { indent = true }))
    end

    -- GET_PED_HEAD_BLEND_DATA
    if Citizen.InvokeNative(0x2746BD9D88C5C5D0, ped, view:Buffer(), Citizen.ReturnResultAnyway()) then
        local blend = {
            shapeFirst = view:GetInt32(0),
            shapeSecond = view:GetInt32(8),
            shapeThird = view:GetInt32(16),
            skinFirst = view:GetInt32(24),
            skinSecond = view:GetInt32(32),
            skinThird = view:GetInt32(40),
            shapeMix = view:GetFloat32(48),
            skinMix = view:GetFloat32(56),
            thirdMix = view:GetFloat32(64),
        }

        -- Output: print(json.encode(blend, { indent = true }))

        -- Manipulate
        view:SetInt32(0, 0)
            :SetInt32(8, 8)
            :SetInt32(16, 16)
            :SetInt32(24, 24)
            :SetInt32(32, 32)
            :SetInt32(40, 40)
            :SetFloat32(48, math.pi)
            :SetFloat32(56, 11.1)
            :SetFloat32(64, -math.pi)
    end

@LICENSE
    See Copyright Notice in lua.h
--]]

local _strblob = string.blob or function(length)
    return string.rep("\0", math.max(40 + 1, length))
end

DataView = {
    EndBig = ">",
    EndLittle = "<",
    Types = {
        Int8 = { code = "i1", size = 1 },
        Uint8 = { code = "I1", size = 1 },
        Int16 = { code = "i2", size = 2 },
        Uint16 = { code = "I2", size = 2 },
        Int32 = { code = "i4", size = 4 },
        Uint32 = { code = "I4", size = 4 },
        Int64 = { code = "i8", size = 8 },
        Uint64 = { code = "I8", size = 8 },

        LuaInt = { code = "j", size = 8 }, -- a lua_Integer
        UluaInt = { code = "J", size = 8 }, -- a lua_Unsigned
        LuaNum = { code = "n", size = 8}, -- a lua_Number
        Float32 = { code = "f", size = 4 }, -- a float (native size)
        Float64 = { code = "d", size = 8 }, -- a double (native size)
        String = { code = "z", size = -1, }, -- zero terminated string
    },

    FixedTypes = {
        String = { code = "c", size = -1, }, -- a fixed-sized string with n bytes
        Int = { code = "i", size = -1, }, -- a signed int with n bytes
        Uint = { code = "I", size = -1, }, -- an unsigned int with n bytes
    },
}
DataView.__index = DataView

--[[ Is a dataview type at a specific offset still within buffer length --]]
local function _ib(o, l, t) return ((t.size < 0 and true) or (o + (t.size - 1) <= l)) end
local function _ef(big) return (big and DataView.EndBig) or DataView.EndLittle end

--[[ Helper function for setting fixed datatypes within a buffer --]]
local SetFixed = nil

--[[ Create an ArrayBuffer with a size in bytes --]]
function DataView.ArrayBuffer(length)
    return setmetatable({
        offset = 1, length = length, blob = _strblob(length)
    }, DataView)
end

--[[ Wrap a non-internalized string --]]
function DataView.Wrap(blob)
    return setmetatable({
        offset = 1, blob = blob, length = blob:len(),
    }, DataView)
end

function DataView:Buffer() return self.blob end
function DataView:ByteLength() return self.length end
function DataView:ByteOffset() return self.offset end
function DataView:SubView(offset)
    return setmetatable({
        offset = offset, blob = self.blob, length = self.length,
    }, DataView)
end

--[[ Create the API by using DataView.Types. --]]
for label,datatype in pairs(DataView.Types) do
    DataView["Get" .. label] = function(self, offset, endian)
        local o = self.offset + offset
        if _ib(o, self.length, datatype) then
            local v,_ = string.unpack(_ef(endian) .. datatype.code, self.blob, o)
            return v
        end
        return nil -- Out of bounds
    end

    DataView["Set" .. label] = function(self, offset, value, endian)
        local o = self.offset + offset
        if _ib(o, self.length, datatype) then
            return SetFixed(self, o, value, _ef(endian) .. datatype.code)
        end
        return self -- Out of bounds
    end

    -- Ensure cache is correct.
    if datatype.size >= 0 and string.packsize(datatype.code) ~= datatype.size then
        local msg = "Pack size of %s (%d) does not match cached length: (%d)"
        error(msg:format(label, string.packsize(fmt[#fmt]), datatype.size))
        return nil
    end
end

for label,datatype in pairs(DataView.FixedTypes) do
    DataView["GetFixed" .. label] = function(self, offset, typelen, endian)
        local o = self.offset + offset
        if o + (typelen - 1) <= self.length then
            local code = _ef(endian) .. "c" .. tostring(typelen)
            local v,_ = string.unpack(code, self.blob, o)
            return v
        end
        return nil -- Out of bounds
    end

    DataView["SetFixed" .. label] = function(self, offset, typelen, value, endian)
        local o = self.offset + offset
        if o + (typelen - 1) <= self.length then
            local code = _ef(endian) .. "c" .. tostring(typelen)
            return SetFixed(self, o, value, code)
        end
        return self
    end
end

--[[ Helper function for setting fixed datatypes within a buffer --]]
SetFixed = function(self, offset, value, code)
    local fmt = { }
    local values = { }

    -- All bytes prior to the offset
    if self.offset < offset then
        local size = offset - self.offset
        fmt[#fmt + 1] = "c" .. tostring(size)
        values[#values + 1] = self.blob:sub(self.offset, size)
    end

    fmt[#fmt + 1] = code
    values[#values + 1] = value

    -- All bytes after the value (offset + size) to the end of the buffer
    -- growing the buffer if needed.
    local ps = string.packsize(fmt[#fmt])
    if (offset + ps) <= self.length then
        local newoff = offset + ps
        local size = self.length - newoff + 1

        fmt[#fmt + 1] = "c" .. tostring(size)
        values[#values + 1] = self.blob:sub(newoff, size)
    end

    self.blob = string.pack(table.concat(fmt, ""), table.unpack(values))
    self.length = self.blob:len()
    return self
end

---------------------------------------
------------- Data Stream -------------
---------------------------------------

--[[ Simple stream API (offset changes) on a dataview. --]]
DataStream = { }
DataStream.__index = DataStream

function DataStream.New(view)
    return setmetatable({ view = view, offset = 0, }, DataStream)
end

--[[ Generate the API by using DataView.Types. --]]
for label,datatype in pairs(DataView.Types) do
    DataStream[label] = function(self, endian, align)
        local o = self.offset + self.view.offset
        if not _ib(o, self.view.length, datatype) then -- Out of bounds
            return nil
        end

        local v,no = string.unpack(_ef(endian) .. datatype.code, self.view:Buffer(), o)
        if align then
            self.offset = self.offset + math.max(no - o, align)
        else
            self.offset = no - self.view.offset
        end
        return v
    end
end