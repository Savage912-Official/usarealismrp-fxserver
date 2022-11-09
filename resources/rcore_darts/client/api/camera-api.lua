local cinemaLook = false
local blockInput = false
local blockInputLast = false
CAMERAS = { }

function createCamera(name, pos, rot, fov)
    fov = fov or 60.0
    rot = rot or vector3(0, 0, 0)
    local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, fov, false, 0)
    local try = 0
    dbg.info('Creating camera %s', cam)
    while cam == -1 or cam == nil do
        cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, fov, false, 0)
        try = try + 1
        Wait(0)
        if try > 20 then
            dbg.critical('Not able to create the camera')
            return nil
        end
    end
    local self = {}
    self.cam = cam
    self.position = pos
    self.rotation = rot
    self.fov = fov
    self.name = name
    self.lastPointTo = nil
    self.pointTo = function(pos)
        --dprint('Trying to point cam %s to %s', self.name, pos)
        self.lastPointTo = pos
        PointCamAtCoord(self.cam, pos.x, pos.y, pos.z)
    end
    self.render = function()
        --dprint('Seting cam %s (%s) active and render script cams', self.name, self.cam)
        SetCamActive(self.cam, true)
        RenderScriptCams(true, true, 1, true, true)
    end
    self.changeCam = function(newCam, duration)
        --dprint('Trying to change cam from %s to %s', self.cam, newCam)
        duration = duration or 3000
        SetCamActiveWithInterp(newCam, self.cam, duration, true, true)
    end
    self.setActive = function(active)
        SetCamActive(self.cam, active)
    end
    self.destroy = function()
        SetCamActive(self.cam, false)
        DestroyCam(self.cam)
        CAMERAS[name] = nil
    end
    self.changePosition = function(newPos, newPoint, newRot, duration)
        newRot = newRot or vector3(0, 0, 0)
        duration = duration or 4000
        if IsCamRendering(self.cam) then
            --Create new temp cam at new coords
            local tempCam = createCamera(string.format('tempCam-%s', self.name), newPos, newRot, self.fov)
            tempCam.render()
            if self.lastPointTo ~= nil then
                tempCam.pointTo(newPoint)
            end

            self.changeCam(tempCam.cam, duration)
            Wait(duration)
            self.destroy()

            local newMain = deepCopy(tempCam)
            newMain.name = self.name
            self = newMain
            return self
        else
            createCamera(self.name, newPos, newRot, self.fov)
        end
    end
    self.isRendering = function()
        return IsCamRendering(self.cam)
    end

    CAMERAS[name] = self
    return self
end

exports('createCamera', createCamera)

function stopRendering()
    RenderScriptCams(false, false, 1, false, false)
end

exports('stopRendering', stopRendering)

RegisterNetEvent('rcore_darts:client:handleFinish', stopRendering)
