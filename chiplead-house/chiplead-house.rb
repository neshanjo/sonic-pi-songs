use_bpm 120

live_loop :pulse, delay: 0.1 do
  sample :loop_amen, beat_stretch: 4, amp: 2
  sleep 4
end

live_loop :bd, sync: :pulse do
  sample :bd_haus, amp: 1
  sleep 1
end

live_loop :hh, sync: :pulse do
  sleep 0.5
  sample :drum_cymbal_open, finish: 0.2, amp: 0.4
  sleep 0.5
end

live_loop :bass, sync: :pulse do
  use_synth :pretty_bell
  volume = 1.5
  16.times do
    play :c2, amp: volume if (spread 5, 8, rotate: 2).tick
    sleep 0.25
  end
  16.times do
    play :bb1, amp: volume if (spread 5, 8, rotate: 2).tick
    sleep 0.25
  end
  16.times do
    play :f1, amp: volume if (spread 5, 8, rotate: 2).tick
    sleep 0.25
  end
  16.times do
    play :c2, amp: volume if (spread 5, 8, rotate: 2).tick
    sleep 0.25
  end
end

live_loop :lead, sync: :pulse do
  with_fx :lpf, cutoff: (line 70, 120, steps: 64).reflect.tick do
    use_synth :chiplead
    use_octave 0
    use_synth_defaults width: 2
    play (scale :c4, :minor_pentatonic, num_octaves: 2).tick
    sleep 0.25
  end
end

live_loop :snareriser, sync: :pulse do
  stop
  sample :drum_snare_hard,
    amp: (line 0, 0.7, inclusive: true, steps: 64).ramp.tick
  sleep 0.25
end
