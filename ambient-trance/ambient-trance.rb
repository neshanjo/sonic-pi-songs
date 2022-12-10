# Welcome to Sonic Pi
use_bpm 120

live_loop :mixer, delay: 0.1 do
  set :amp_bd, 2
  set :amp_sn, 1
  set :amp_hh, 2
  set :amp_bass, 1.5
  set :bass_extended, true
  set :amp_pad, 0.6
  set :amp_pattern, 1.5
  sleep 4
end

live_loop :kick, sync: :mixer do
  sample :bd_haus, amp: get[:amp_bd]
  sleep 1
end

with_fx :reverb, mix: 0.3, room: 0.5 do
  live_loop :snare, sync: :mixer do
    sleep 1
    sample :sn_dolf, amp: get[:amp_sn]
    sleep 1
  end
end

live_loop :hihat, sync: :mixer do
  sleep 0.51
  sample :drum_cymbal_closed, amp: get[:amp_hh]
  sleep 1
  sample :drum_cymbal_closed, amp: get[:amp_hh] if one_in(2)
  sleep 1
  sample :drum_cymbal_closed, amp: get[:amp_hh]
  sleep 1
  sample :drum_cymbal_closed, amp: get[:amp_hh]
  sleep 0.25
  sample :drum_cymbal_closed, amp: get[:amp_hh]*0.8 if one_in(4)
  sleep 0.24
end

live_loop :bass, sync: :mixer do
  use_synth :tb303
  with_fx :slicer, phase: 1, wave: 1, invert_wave: 1 do
    sn = play :e1, cutoff: 60, res: 0.5, cutoff_attack: 0,
      attack: 0, decay: 0, sustain: 8, release: 0,
      amp: get[:amp_bass]
    sleep 6
    control sn, note: :g1
    sleep 2
    if (get[:bass_extended]) then
      sn = play :d2, cutoff: 60, res: 0.5, cutoff_attack: 0,
        attack: 0, decay: 0, sustain: 8, release: 0,
        amp: get[:amp_bass]
      sleep 6
      control sn, note: :g1
      sleep 2
      sn = play :c2, cutoff: 60, res: 0.5, cutoff_attack: 0,
        attack: 0, decay: 0, sustain: 8, release: 0,
        amp: get[:amp_bass]
      sleep 6
      control sn, note: :g1
      sleep 2
      sn = play :b1, cutoff: 60, res: 0.5, cutoff_attack: 0,
        attack: 0, decay: 0, sustain: 8, release: 0,
        amp: get[:amp_bass]
      sleep 8
    end
  end
end

live_loop :pad, sync: :mixer do
  with_fx :wobble, phase: 1, invert_wave: 0 do
    sample :ambi_drone, amp: get[:amp_pad], rate: 0.623*2, sustain: 4, release: 0
    #play :e4
    sleep 4
  end
end

live_loop :pattern, sync: :mixer do
  coefs = (ring 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.75, 0.7, 0.65, 0.6, 0.55).stretch(4)
  with_fx :echo, phase: 0.75, decay: 4, mix: 0.7 do
    use_synth :pluck
    coef = coefs.tick
    play (ring :e3, :b3, :e4).tick(:left), amp: get[:amp_pattern], pan: -0.4, coef: coef
    play (ring :g4, :gb4, :g4, :gb4, :e4, :r).tick(:right), amp: get[:amp_pattern], pan: 0.4, coef: coef
    sleep 0.5
  end
end