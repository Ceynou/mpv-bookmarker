local delay = 2
local current_bookmark = 1
local bookmarks = {}
local snap_to_subtitle = true
local display_osd = false
local time_pos

local function time_pos_update()
    time_pos = mp.get_property_number("time-pos") - delay
    if snap_to_subtitle == true then
        time_pos = mp.get_property_number("sub-start") or time_pos
    end
end

local function create_bookmark()
    time_pos_update()
    bookmarks[#bookmarks+1] = time_pos
    if display_osd then
        mp.osd_message("bookmark " .. #bookmarks .. " (" .. time_pos .. ")", 1)
    end
end

local function cycle_bookmark()
    mp.commandv("seek", bookmarks[current_bookmark], "absolute+exact")
    if display_osd then
        mp.osd_message("bookmark " .. current_bookmark, 1)
    end
    if current_bookmark == #bookmarks then 
        current_bookmark = 1 
    else 
        current_bookmark = current_bookmark + 1 
    end
end

mp.add_key_binding("b", "create_bookmark", create_bookmark)
mp.add_key_binding("B", "cycle_bookmark", cycle_bookmark, {repeatable=true})
