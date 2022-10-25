fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_scripts {
  'cl_characters.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'classes/character.lua',
  'sv_characters.lua'
}

server_exports {
  'SaveCurrentCharacter',
  'CreateNewCharacter',
  'LoadCharactersForSelection',
  'InitializeCharacter',
  'GetCharacter',
  'GetCharacters',
  'GetCharacterField',
  'SetCharacterField',
  'GetNumCharactersWithJob',
  'DoesCharacterHaveItem',
  "GetPlayerIdsWithJob"
}