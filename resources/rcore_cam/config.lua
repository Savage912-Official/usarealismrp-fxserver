Config = {
    Framework = {
        ESX = false,
        QBCORE = false,
        CUSTOM = true,
    },
    CamAccessWhitelist = {
        ['sheriff'] = true,
        ['corrections'] = true
    },
    MaxRecordingLength = 10 * 60 * 1000, -- 10 minutes
    MaxCamRecordingDistance = 100.0,
    HidePlayerWithConceal = false,
    CamTriggerEvents = { -- serverside network event handlers
        'rcore_cam:shotsFired',
        "rcore_cam:startRecordingSV"
    },
    CamTriggerBlacklistedWeapons = {
        [`WEAPON_STUNGUN`] = true,
        [`WEAPON_SNOWBALL`] = true,
    },
    EntityBlinkingInPlayback = true, -- This makes entities in playback fade in/out a little to signify you are viewing a recording
    CameraModels = {
        [`prop_cctv_cam_05a`] = 'prop_cctv_cam_05a',
        [`prop_cctv_cam_03a`] = 'prop_cctv_cam_03a',
        [`prop_cctv_cam_06a`] = 'prop_cctv_cam_06a',
        [`prop_cctv_cam_04c`] = 'prop_cctv_cam_04c',
        [`prop_cctv_cam_01b`] = 'prop_cctv_cam_01b',
        [`prop_cctv_cam_01a`] = 'prop_cctv_cam_01a',
        [`prop_cctv_cam_04a`] = 'prop_cctv_cam_04a',
        [`prop_cctv_cam_02a`] = 'prop_cctv_cam_02a',
        [`prop_cctv_cam_04b`] = 'prop_cctv_cam_04b',
        [`prop_cctv_cam_07a`] = 'prop_cctv_cam_07a',
        [`hei_prop_bank_cctv_01`] = 'hei_prop_bank_cctv_01',
        [`prop_atm_01`] = 'prop_atm_01',
        [`prop_atm_02`] = 'prop_atm_02',
        [`prop_atm_03`] = 'prop_atm_03',
        [`prop_fleeca_atm`] = 'prop_fleeca_atm',
        [`hei_prop_bank_cctv_02`] = 'hei_prop_bank_cctv_02',
        [`prop_cctv_pole_04`] = 'prop_cctv_pole_04',
    },
    CameraModelOffsets = {
        [`prop_cctv_cam_01a`] = {
            start = vector3(0.15, -0.65, 0.2),
            target = vector3(0.35, -1.0, 0.0),
        },
        [`prop_cctv_cam_03a`] = {
            start = vector3(-0.5, -0.5, 0.3),
            target = vector3(-1.0, -1.0, 0.1),
        },
        [`prop_cctv_cam_06a`] = {
            start = vector3(0.0, -0.2, -0.35),
            target = vector3(0.0, -1.0, -0.7),
        },
        [`prop_cctv_cam_01b`] = {
            start = vector3(-0.22, -0.75, 0.15),
            target = vector3(-0.44, -1.122, -0.05),
        },
        [`prop_cctv_cam_02a`] = {
            start = vector3(0.18, -0.3, -0.08),
            target = vector3(0.72, -1.2, -0.4),
        },
        [`prop_cctv_cam_04a`] = {
            start = vector3(0.0, -0.9, 0.7),
            target = vector3(0.0, -2.0, 0.0),
        },
        [`prop_cctv_cam_04b`] = {
            start = vector3(0.0, -0.8, 0.6),
            target = vector3(0.0, -2.0, 0.0),
        },
        [`prop_cctv_cam_04c`] = {
            start = vector3(0.0, -0.4, -0.3),
            target = vector3(0.0, -2.0, -1.2),
        },
        [`prop_cctv_cam_05a`] = {
            start = vector3(0.0, -0.3, -0.5),
            target = vector3(0.0, -2.0, -1.2),
        },
        [`prop_cctv_cam_07a`] = {
            start = vector3(0.0, -0.4, -0.3),
            target = vector3(0.0, -2.0, -1.2),
        },
        [`hei_prop_bank_cctv_01`] = {
            start = vector3(0.0, -0.4, -0.3),
            target = vector3(0.0, -2.0, -1.2),
        },
        [`hei_prop_bank_cctv_02`] = {
            start = vector3(0.0, -0.0, -0.5),
            target = vector3(0.0, -0.0, -1.0),
        },
        [`prop_atm_01`] = {
            start = vector3(0.0, 0.0, 1.5),
            target = vector3(0.0, -2.0, 1.5),
        },
        [`prop_atm_02`] = {
            start = vector3(0.0, 0.0, 1.5),
            target = vector3(0.0, -2.0, 1.5),
        },
        [`prop_atm_03`] = {
            start = vector3(0.0, 0.0, 1.5),
            target = vector3(0.0, -2.0, 1.5),
        },
        [`prop_fleeca_atm`] = {
            start = vector3(0.0, 0.0, 1.5),
            target = vector3(0.0, -2.0, 1.5),
        },
        [`prop_cctv_pole_04`] = {
            start = vector3(-1.0, 0.0, 4.5),
            target = vector3(-4.0, -2.5, 4.0),
        },
    },
    RecordingStorages = {
        MRPD = {
            pos = vector3(442.7690, -997.5549, 34.0),
            folders = {
                {
                    name = 'evidence_1',
                    label = 'Evidence #1',
                },
                {
                    name = 'evidence_2',
                    label = 'Evidence #2',
                },
                {
                    name = 'evidence_3',
                    label = 'Evidence #3',
                },
                {
                    name = 'evidence_4',
                    label = 'Evidence #4',
                },
                {
                    name = 'evidence_5',
                    label = 'Evidence #5',
                },
                {
                    name = 'evidence_6',
                    label = 'Evidence #6',
                },
                {
                    name = 'evidence_7',
                    label = 'Evidence #7',
                },
                {
                    name = 'evidence_8',
                    label = 'Evidence #8',
                },
                {
                    name = 'evidence_9',
                    label = 'Evidence #9',
                },
                {
                    name = 'evidence_10',
                    label = 'Evidence #10',
                },
            }
        },
    },
    Control = {
        CAM_PAUSE = {
            key = 191,
            name = 'INPUT_FRONTEND_RDOWN',
            label = 'Pause',
        },
        CAM_PLAY = {
            key = 191,
            name = 'INPUT_FRONTEND_RDOWN',
            label = 'Play',
        },
        CAM_REWIND = {
            key = 174,
            name = 'INPUT_CELLPHONE_LEFT',
            label = 'Rewind',
        },
        CAM_FAST_FORWARD = {
            key = 175,
            name = 'INPUT_CELLPHONE_RIGHT',
            label = 'Fast Forward',
        },
        CAM_NEXT_CAM = {
            key = 172,
            name = 'INPUT_CELLPHONE_UP',
            label = 'Next Cam',
        },
        CAM_PREV_CAM = {
            key = 173,
            name = 'INPUT_CELLPHONE_DOWN',
            label = 'Prev. Cam',
        },
        CAM_BACK = {
            key = 194,
            name = 'INPUT_FRONTEND_RRIGHT',
            label = 'Exit Recording',
        },
    },
    Text = {
        CAMPLAY_ALREADY_PLAYING = 'You are already playing a recording',
        RECORDING_TRANSFERED = 'Recording was transfered',
        OPEN_RECORDINGS = '~INPUT_VEH_SHUFFLE~ Open recordings',
        CAM_RECORDINGS = 'Cam Recordings',
        STOP_RECORDING = 'Stop recording',
        RECORDING_PROCESSING = 'Recording is being processed',
        PLAY = 'Play',
        TAKE = 'Take',
        STORE = 'Store',
        GIVE = 'Give',
        SECURITY_GROUP = 'Security Group',
        NO_RECORDINGS = 'No recordings',
        PLAYER = 'Player',
        LOADING_RECORDING = '   Loading recording...',
        OPEN_REC_STORAGE = '~INPUT_PICKUP~ Open recording storage',
        STORED_RECORDINGS = 'Stored recordings',
        YOUR_RECORDINGS = 'Your recordings',
    }
}