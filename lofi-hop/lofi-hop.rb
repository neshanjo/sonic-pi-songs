# (C) by Johannes Schneider, 2020

use_bpm 100
st = 1.059463094 # factor for semitone

live_loop :mixer do
  set :boomclap_enabled, true
  set :rides_enabled, true
  set :bass_enabled, true
  set :rhodes_enabled, true
  set :guitar_enabled, true
  sleep 1
end



live_loop :bass do
  if (get[:bass_enabled]) then
    use_synth :subpulse
    use_synth_defaults attack: 0, decay: 1, decay_level: 0.5,
      sustain: 0, sustain_level: 0, cutoff: 80, release: 0.5,
      amp: 1.5
    3.times do
      play :f2
      sleep 1.6
      play :eb2, decay: 0.5
      sleep 0.4
      play :f1, sustain: 1, sustain_level: 0.5
      sleep 2
      sleep 4
    end
    play :gb2
    sleep 1.6
    play :gb2, sustain: 1, sustain_level: 0.5
    sleep 6.4
  else
    sleep 32
  end
end

live_loop :rhodes do
  if (get[:rhodes_enabled]) then
    use_synth :fm
    use_synth_defaults release: 8, divisor: 1, depth: 2
    with_fx :flanger, stereo_invert_wave: 1 do
      with_fx :bitcrusher, sample_rate: 22000, bits: 12 do
        play [:f3, :ab3, :c4, :eb4, :g4, :bb4], release: 7
        sleep 6.6
        play [:gb3, :a3, :db4, :e4, :ab4, :b4], sustain: 1, release: 0.6
        sleep 1.4
        
        play [:f3, :ab3, :c4, :eb4, :g4, :bb4]
        sleep 8
        
        play [:f3, :ab3, :c4, :eb4, :g4, :bb4]
        sleep 8
        
        play [:gb3, :a3, :db4, :e4, :ab4, :b4], release: 4
        sleep 4
        play [:e3, :g3, :b3, :d4, :gb4, :a4], release: 4
        sleep 4
      end
    end
  else
    sleep 32
  end
end

live_loop :guitar do
  if (get[:guitar_enabled]) then
    with_fx :flanger, stereo_invert_wave: 1 do
      with_fx :hpf, cutoff: 70 do
        sleep 8
        
        sleep 1
        sample :guit_e_fifths, rate: st, amp: 0.8
        sleep 7
        
        sleep 1.05
        sample :guit_harmonics, rate: st, amp: 1.5, pan: 1
        sleep 1.05
        sample :guit_harmonics, rate: st, amp: 1.5, pan: -1
        sleep 5.9
        
        sleep 4
        sample :guit_em9, finish: 0.25, amp: 0.8
        sleep 4
      end
    end
  else
    sleep 32
  end
end

live_loop :boomclap do
  if (get[:boomclap_enabled]) then
    with_fx :bitcrusher, sample_rate: 22000, bits: 7 do
      3.times do
        sample :drum_bass_hard, decay: 0.02, decay_level: 0.2, amp: 1.1, sustain: 0.1, release: 0.1
        sleep 0.96
        sample :elec_hi_snare, rate: 0.8, pan: -0.1, amp: 1.5
        sleep 1.04
      end
      sleep 0.6
      sample :drum_bass_hard, decay: 0.02, decay_level: 0.2, amp: 1.1, sustain: 0.1, release: 0.1 if (ring true, false).tick
      sleep 0.36
      sample :elec_hi_snare, rate: 0.8, pan: -0.1, amp: 1.5
      sleep 1.04
    end
  else
    sleep 8
  end
end

live_loop :rides do
  if get[:rides_enabled] then
    with_fx :bitcrusher, sample_rate: 22000, bits: 12 do
      sample :drum_cymbal_soft, amp: 0.6, pan: 0.1
      sleep 0.6
      sample :drum_cymbal_soft, amp: 0.7, pan: 0.1
      sleep 0.4
    end
  else
    sleep 1
  end
end

live_loop :vinyl do
  sample :vinyl_hiss, amp: 1.2
  sleep 8
end