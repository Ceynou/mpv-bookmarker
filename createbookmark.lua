local delay = 2
local current_bookmark = 1
local bookmarks = {}

local function create_bookmark()
    local time_pos = mp.get_property_number("time-pos")
    local time_pos_osd = mp.get_property_osd("time-pos/full")

    bookmarks[#bookmarks+1] = time_pos - delay
    mp.osd_message("bookmark " .. #bookmarks .. "(" .. time_pos_osd .. ")", 1)
end

local function cycle_bookmark()
    mp.commandv("seek", bookmarks[current_bookmark], "absolute+exact")
    mp.osd_message("bookmark " .. current_bookmark, 1)
    current_bookmark = current_bookmark + 1
    if current_bookmark == #bookmarks then current_bookmark = 1 end
end
mp.add_key_binding("b", "create_bookmark", create_bookmark, {repeatable=true})
mp.add_key_binding("B", "cycle_bookmark", cycle_bookmark)
