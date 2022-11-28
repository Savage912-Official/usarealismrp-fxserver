Config = {}

Config.Debug = false

-- Command to open the rgb controller menu
Config.Command = {
    Enabled = true,
    Command = 'rgbcontrolleritemlol'
}

-- Keybind to open the rgb controller menu
Config.Keybind = {
    Enabled = false,
    SpecialKey = 'LEFTCTRL',
    Key = 'M',
}

-- If players should be able to change the color of their headlights
Config.AllowHeadlights = true

--[[
Here you can make new animations or remove ones which you do not want players to use

Normal types:
    'rgb'
        This type will set the color of the underglow (neon)
        Parameters:
         r = "The red color"
         g = "The green color"
         b = "The blue color"
        All these values go betweeen 0 and 255
        To turn off the neon set them all to 0 (black)

    'xenon'
        This type will set the color of the xenon headlights
        Parameters:
          color = "The color which the headlights will be set to (Possible colors listed below)"

    'delay'
        This type will simply add a delay to your "animation"
        Parameters:
          time = "Time in milliseconds which the animation will wait for before taking next step"

    'rgb-saved'
        This type will reset/set the color of the underglow to whatever was selected by the user manually
        Parameters: N/A

    'rainbow'
        This type will set the underglow of the car to a random color from a list defined in client.lua
        This list contains few different colors
        Parameters: N/A

    There are a couple special types like "smooth", "breathing" and "speed-reactive"
        These were made specifically for one purpose, feel free to explore them if you understand what is happening
        if not please leave those be.


    headlightColors {
        Default = -1,
        White = 0,
        Blue = 1,
        Electric_Blue = 2,
        Mint_Green = 3,
        Lime_Green = 4,
        Yellow = 5,
        Golden_Shower = 6,
        Orange = 7,
        Red = 8,
        Pony_Pink = 9,
        Hot_Pink = 10,
        Purple = 11,
        Blacklight = 12
    }
]]--

Config.Animations = {
    {
        name = 'RGB',
        sequence = {
            {
                type = 'smooth',
            },
            {
                type = 'delay',
                time = 300,
            },
        }
    },
    {
        name = 'RGB (Fast)',
        sequence = {
            {
                type = 'smooth',
            },
            {
                type = 'delay',
                time = 120,
            },
        }
    },
    {
        name = 'Breathing (Colored)',
        sequence = {
            {
                type = 'breathing',
            },
            {
                type = 'delay',
                time = 100,
            },
        }
    },
    {
        name = 'Flash (Colored)',
        sequence = {
            {
                type = 'rgb-saved',
            },
            {
                type = 'delay',
                time = 300,
            },
            {
                type = 'rgb',
                r = 255,
                g = 255,
                b = 255,
            },
            {
                type = 'delay',
                time = 300,
            },
        }
    },
    {
        name = 'Blink (Colored)',
        sequence = {
            {
                type = 'rgb-saved',
            },
            {
                type = 'delay',
                time = 300,
            },
            {
                type = 'rgb',
                r = 0,
                g = 0,
                b = 0,
            },
            {
                type = 'delay',
                time = 300,
            },
        }
    },
    {
        name = 'Speed Reactive (Colored)',
        sequence = {
            {
                type = 'speed-reactive',
            },
            {
                type = 'delay',
                time = 500,
            },
        }
    },
    {
        name = 'Breathing (Colored)',
        sequence = {
            {
                type = 'breathing',
            },
            {
                type = 'delay',
                time = 100,
            },
        }
    },
    {
        name = 'Police',
        sequence = {
            {
                type = 'rgb',
                r = 255,
                g = 0,
                b = 0,
            },
            {
                type = 'xenon',
                color = 8,
            },
            {
                type = 'delay',
                time = 300,
            },
            {
                type = 'rgb',
                r = 0,
                g = 0,
                b = 255,
            },
            {
                type = 'xenon',
                color = 1,
            },
            {
                type = 'delay',
                time = 300,
            },
        }
    },
    {
        name = 'Ambulance',
        sequence = {
            {
                type = 'rgb',
                r = 255,
                g = 0,
                b = 0,
            },
            {
                type = 'xenon',
                color = 8,
            },
            {
                type = 'delay',
                time = 300,
            },
            {
                type = 'rgb',
                r = 255,
                g = 255,
                b = 255,
            },
            {
                type = 'xenon',
                color = 0,
            },
            {
                type = 'delay',
                time = 300,
            },
        }
    },
    {
        name = 'Stroboscope',
        sequence = {
            {
                type = 'rgb',
                r = 255,
                g = 255,
                b = 255,
            },
            {
                type = 'delay',
                time = 150,
            },
            {
                type = 'rgb',
                r = 0,
                g = 0,
                b = 0,
            },
            {
                type = 'delay',
                time = 150,
            },
        }
    },
    {
        name = 'Rainbow',
        sequence = {
            {
                type = 'rainbow',
            },
            {
                type = 'delay',
                time = 300,
            },
        }
    },
    {
        name = 'Changing',
        sequence = {
            {
                type = 'rainbow',
            },
            {
                type = 'delay',
                time = 2000,
            },
        }
    },
    {
        name = 'Fire',
        sequence = {
            {
                type = 'rgb',
                r = 255,
                g = 10,
                b = 0,
            },
            {
                type = 'xenon',
                color = 8,
            },
            {
                type = 'random-delay',
                min = 100,
                max = 300,
            },
            {
                type = 'rgb',
                r = 255,
                g = 40,
                b = 0,
            },
            {
                type = 'random-delay',
                min = 100,
                max = 300,
            },
            {
                type = 'rgb',
                r = 255,
                g = 30,
                b = 10,
            },
            {
                type = 'random-delay',
                min = 100,
                max = 300,
            },
            {
                type = 'rgb',
                r = 245,
                g = 0,
                b = 0,
            },
            {
                type = 'xenon',
                color = 7,
            },
            {
                type = 'random-delay',
                min = 100,
                max = 300,
            },
        }
    },
    {
        name = 'Lolipop',
        sequence = {
            {
                type = 'rgb',
                r = 255,
                g = 0,
                b = 255,
            },
            {
                type = 'xenon',
                color = 10,
            },
            {
                type = 'delay',
                time = 400,
            },
            {
                type = 'rgb',
                r = 255,
                g = 70,
                b = 255,
            },
            {
                type = 'xenon',
                color = 9,
            },
            {
                type = 'delay',
                time = 400,
            },
            {
                type = 'rgb',
                r = 60,
                g = 0,
                b = 220,
            },
            {
                type = 'xenon',
                color = 11,
            },
            {
                type = 'delay',
                time = 400,
            },
        }
    },
    {
        name = 'U.F.O',
        sequence = {
            {
                type = 'rgb',
                r = 40,
                g = 255,
                b = 0,
            },
            {
                type = 'xenon',
                color = 0,
            },
            {
                type = 'delay',
                time = 300,
            },
            {
                type = 'rgb',
                r = 255,
                g = 255,
                b = 255,
            },
            {
                type = 'xenon',
                color = 4,
            },
            {
                type = 'delay',
                time = 300,
            },
        }
    },
    {
        name = 'Ocean waves',
        sequence = {
            {
                type = 'rgb',
                r = 10,
                g = 60,
                b = 255,
            },
            {
                type = 'xenon',
                color = 0,
            },
            {
                type = 'delay',
                time = 300,
            },
            {
                type = 'rgb',
                r = 255,
                g = 255,
                b = 255,
            },
            {
                type = 'xenon',
                color = 2,
            },
            {
                type = 'delay',
                time = 300,
            },
        }
    },
    {
        name = 'Demonic',
        sequence = {
            {
                type = 'rgb',
                r = 255,
                g = 0,
                b = 0,
            },
            {
                type = 'xenon',
                color = 8,
            },
            {
                type = 'random-delay',
                min = 100,
                max = 1300,
            },
            {
                type = 'rgb',
                r = 0,
                g = 0,
                b = 0,
            },
            {
                type = 'xenon',
                color = -1,
            },
            {
                type = 'random-delay',
                min = 100,
                max = 6000,
            },
        }
    },
}

--[[
    Here you can make new "Toggles" aka "Secondary animations"

    There are only 5 parameters which are REQUIRED in each step
    those are as follows:
        front (front underglow)
        right (right underglow)
        rear (rear underglow)
        left (left underglow)
        duration (How long the underglow should stay in that configuration before moving on to the next step)

   <!> <!>
      PLEASE MAKE SURE THAT AT NO POINT YOU TURN OFF ALL THE UNDERGLOWS (NEONS) AT ONCE. TO ACHIEVE THAT USE
      THE PRIMARY ANIMATION AND SET THE RGB TO 0, 0, 0 (BLACK). HAVING AT LEAST ONE UNDERGLOW ENABLED MAKES IT
      POSSIBLE FOR US TO DETECT IF THE CAR HAS EQUIPPED/PURCHASED UNDERGLOW. IF YOU TURN THEM ALL OFF WE WON'T
      BE ABLE TO TELL THAT THE CAR HAS EQUIPPED UNDERGLOW (NEON)
   <!> <!>
]]--

Config.Toggles = {
    {
        name = 'Normal',
        sequence = {
            {
                front = true,
                right = true,
                rear = true,
                left = true,
                duration = 1000,
            },
        }
    },
    {
        name = 'Rotate',
        sequence = {
            {
                front = true,
                right = false,
                rear = false,
                left = false,
                duration = 300,
            },
            {
                front = false,
                right = true,
                rear = false,
                left = false,
                duration = 300,
            },
            {
                front = false,
                right = false,
                rear = true,
                left = false,
                duration = 300,
            },
            {
                front = false,
                right = false,
                rear = false,
                left = true,
                duration = 300,
            },
        }
    },
    {
        name = 'Flip-Flap',
        sequence = {
            {
                front = true,
                right = false,
                rear = true,
                left = false,
                duration = 300,
            },
            {
                front = false,
                right = true,
                rear = false,
                left = true,
                duration = 300,
            },
        }
    },
    {
        name = 'Left To Right',
        sequence = {
            {
                front = false,
                right = true,
                rear = false,
                left = false,
                duration = 300,
            },
            {
                front = false,
                right = false,
                rear = false,
                left = true,
                duration = 300,
            },
        }
    },
    {
        name = 'Front to Back',
        sequence = {
            {
                front = true,
                right = false,
                rear = false,
                left = false,
                duration = 300,
            },
            {
                front = false,
                right = false,
                rear = true,
                left = false,
                duration = 300,
            },
        }
    },
    {
        name = 'Sides',
        sequence = {
            {
                front = false,
                right = true,
                rear = false,
                left = true,
                duration = 1000,
            },
        }
    },
    {
        name = 'Front and Back',
        sequence = {
            {
                front = true,
                right = false,
                rear = true,
                left = false,
                duration = 1000,
            },
        }
    }
}