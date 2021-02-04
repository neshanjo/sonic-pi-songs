use_bpm 120


with_fx :reverb, room: 1, damp: 0.8 do
  
  live_loop :bg do
    sample :ambi_sauna, amp: 0.2, attack: 2
    sleep 10
  end
  
  live_loop :piano_r do
    use_synth :piano
    use_synth_defaults release: 8
    play (ring :e2, :b5, :d5, :b3, :a4).tick, pan: 0.6,
      amp: (knit 0, 10, 1, 18).tick
    sleep (rrand_i 3, 11)
  end
  
  live_loop :piano_l do
    sleep 3.5
    use_synth :piano
    use_synth_defaults release: 8
    play (ring :a5, :b2, :d3, :a3, :e2, :e3).tick, pan: -0.6,
      amp: (knit 0, 14, 1, 20).tick
    sleep (rrand_i 3, 11)
  end
  
  live_loop :hum do
    with_fx :ping_pong, mix: 1 do
      sample :ambi_glass_hum, pitch: +7, amp: (knit 0, 8, 1, 12).tick
      sleep 4
    end
  end
  
  live_loop :drone do
    sample :ambi_glass_rub, pitch: -26, amp: (knit 0, 4, 0.4, 16).tick
    sleep 5
  end
  
  live_loop :fill do
    with_fx :panslicer, wave: 3 do
      sleep 60
      sample :ambi_lunar_land, pitch: -8, amp: 0.7
    end
  end
  
  live_loop :more do
    sample :guit_harmonics, rate: 0.25, amp: (knit 0, 7, 1, 7).tick
    sleep 8
  end
  
end