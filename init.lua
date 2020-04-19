-- olliy


info = {}

local items = {
    "no info at the moment",
}

for i = 1, #items do
        items[i] = minetest.formspec_escape(items[i])
end
info.txt = table.concat(items, ",")

minetest.register_chatcommand("info", {
    func = function(name, param)
            if param ~= "" and
                            minetest.check_player_privs(name, { kick = true }) then
                    name = param
            end

            local player = minetest.get_player_by_name(name)
            if player then
                    info.show(player)
                    return true, "info shown."
            else
                    return false, "Player " .. name .. " does not exist or is not online"
            end
    end
})

minetest.register_on_joinplayer(function(player)
            local name = player:get_player_name()
            if name then 
                minetest.after(5, minetest.chat_send_player, name, "Hi " .. name .. ". You can review more infomation about the server by running /info")
            else
                print("Something went wrong")
            end
end)

function info.show(player)
    local fs = "size[9,7]bgcolor[#080808BB;true]" ..
                    default.gui_bg ..
                    default.gui_bg_img ..
                    "textlist[0.1,0.1;8.8,6.3;msg;" .. info.txt .. ";-1;true]"..
                    "button_exit[0.5,6;7,2;yes;Okay]"

    minetest.show_formspec(player:get_player_name(), "info:info", fs)
end