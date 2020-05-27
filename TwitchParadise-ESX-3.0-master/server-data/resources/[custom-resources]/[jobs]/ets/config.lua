Config = {
    JobCenter = vector3(931.89, -2267.38, 30.84),
    ReAdd = 60, -- seconds after a job is finished until its shown again
    Job = {
        ['jobRequired'] = false, -- if true: only players with the specified job can work, false everyone can work
        ['jobName'] = 'trucker',
    },
    Jobs = {
        -- {title = 'title', payment = reward, vehicles = {'truck', 'trailer'}, start = {vector3(x, y, z), heading}, trailer = {vector3(x, y, z), heading}, arrive = vector3(x, y, z)}
        {title = 'Drive a load of furniture to IKEA', payment = 850, vehicles = {'phantom', 'trailers'}, start = {vector3(954.77, -2188.86, 29.63), 84.99}, trailer = {vector3(939.0, -1799.2, 30.1), 175.78}, arrive = vector3(2671.0, 3530.35, 51.26)},
        {title = 'Drive a load of meat to the supermarket', payment = 300, vehicles = {'packer', 'trailers2'}, start = {vector3(868.77, -2341.7, 29.44), 174.68}, trailer = {vector3(946.29, -2111.86, 29.64), 86.76}, arrive = vector3(103.57, -1819.37, 25.56)},
        {title = 'Drive a load of cars to PDM', payment = 600, vehicles = {'phantom', 'tr4'}, start = {vector3(954.77, -2188.86, 29.63), 84.99}, trailer = {vector3(1274.86, -3185.32, 6.139), 89.90}, arrive = vector3(-58.202, -1051.061, 26.8)},
        {title = 'Drive a tanker of fuel to a fuel station', payment = 585, vehicles = {'hauler', 'tanker'}, start = {vector3(954.77, -2188.86, 29.63), 84.99}, trailer = {vector3(1699.52, -1500.15, 113.226), 69.63}, arrive = vector3(-2101.86, -293.84, 13.261)}
    },
}



Strings = {
    ['not_job'] = "You don't have the trucker job!",
    ['somebody_doing'] = 'Somebody is already doing this job, please select another one!',
    ['menu_title'] = 'Trucker - choose job',
    ['e_browse_jobs'] = 'Press ~INPUT_CONTEXT~ to browse available jobs',
    ['start_job'] = 'Haulage work',
    ['truck'] = 'Truck',
    ['trailer'] = 'Trailer',
    ['get_to_truck'] = 'Get to the ~y~truck~w~!',
    ['get_to_trailer'] = 'Drive to the ~y~trailer~w~ and attach it!',
    ['destination'] = 'Destination',
    ['get_out'] = 'Get out of your ~y~truck~w~!',
    ['park'] = 'Park the ~y~trailer~w~ at the destination.',
    ['park_truck'] = 'Park the ~y~truck~w~ at the destination.',
    ['drive_destination'] = 'Drive to the ~b~destination~w~.',
    ['reward'] = 'Job complete! You recieved ~g~$~w~%s',
    ['paid_damages'] = 'Drive better next time! You paid ~r~$~w~%s for the damages caused!',
    ['drive_back'] = 'Drive the ~y~truck ~w~back to where you got it.', 
    ['detach'] = 'Detach the trailer.'
}