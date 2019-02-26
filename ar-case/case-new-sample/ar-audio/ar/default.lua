app_controller = ae.ARApplicationController:shared_instance()
local script_vm = app_controller:get_script_vm()
script_vm:require_module("./scripts/include.lua")
local application = app_controller:add_application_with_name("my_ar_application")
application:add_scene_from_json("res/simple_scene.json","demo_scene")
application:active_scene_by_name("demo_scene")

scene = application:get_current_scene()
--application:open_imu_service(1,1)

function on_loading_finish() 
    audio()
end
application:set_script_loading_finish_handler(on_loading_finish)

function audio()
    audio_node = scene:get_node_by_name("ResumeButton")
    rigid_controller = audio_node:get_media_controller()
    rigid_config = {}
    rigid_config["repeat_count"] =0
    --rigid_config["delay"] = 5000

    rigid_session = rigid_controller:create_media_session("audio","/res/media/testcase.mp3", rigid_config)
    rigid_session:play()
    AR:perform_after(5000, function()
        rigid_session:pause()
        ARLOG("pause rotate animation")

        AR:perform_after(5000, function()
            rigid_session:play()
            ARLOG("play rotate animation")

            AR:perform_after(5000, function()
                rigid_session:stop()
                ARLOG("stop rotate animation")
            end)
        end)
    end)
end


-- function state_handler(session_id, state)
--     ARLOG("ar_qa:state of session "..tostring(session_id).." changed to "..state)
-- end








