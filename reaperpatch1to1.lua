--[[
 * ReaScript Name: Patch out 1 to 1
 * About: Patch selected tracks 1 to 1 starting from out 1.
 * Instructions: Select tracks. Use it.
 * Author: Cristiano Grassini
 * Repository: GitHub > grassinicristiano > ReaperPatch1to1
 * Repository URI: https://github.com/grassinicristiano/ReaperPatch1to1.git
 * Licence: GPL v3
 * Version: 1.0
]]


maxout = reaper.GetNumAudioOutputs()
tracknumber = reaper.GetNumTracks()
selected = reaper.CountSelectedTracks(0)
    
if selected == 0 then
    reaper.ShowMessageBox("Please select a track!", "Error", 0)
end

check = 1
index = 0
if selected ~= 0 then
  while check == 1 do
    p = reaper.GetTrack(0, index)
    if reaper.IsTrackSelected(p) then
      firstTrack = index
      check = 0
    end
    index = index + 1
  end
  trackOutStart = 1024
  for i = firstTrack, (firstTrack+selected-1) do
    t = reaper.GetTrack(0, i)
    send = reaper.GetTrackNumSends(t, 1)
    if send == 0 then
      reaper.CreateTrackSend(t)
    end
    
    reaper.SetTrackSendInfo_Value(t, 1, 0, "I_DSTCHAN", trackOutStart)
    reaper.SetTrackSendInfo_Value(t, 1, 0, "D_VOL", 1)
    reaper.SetTrackSendInfo_Value(t, 1, 0, "D_PAN", 0)
    reaper.SetTrackSendInfo_Value(t, 1, 0, "I_SENDMODE", 0)
    reaper.SetTrackSendInfo_Value(t, 1, 0, "I_SRCCHAN", 0)
    reaper.SetTrackSendInfo_Value(t, 1, 0, "B_MONO", 1)
    reaper.SetMediaTrackInfo_Value(t, "B_MAINSEND", 0)
    trackOutStart = trackOutStart + 1
  end
end
