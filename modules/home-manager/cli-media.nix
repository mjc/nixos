{pkgs, ...}: {
  home.packages = with pkgs; [
    ab-av1
    ffmpeg-full
    mediainfo

    mkvtoolnix

    # TODO: consolidate these.
    (writeShellScriptBin "av1-atmos" ''
      video="--pix-format yuv420p10le"
      # grain="--svt film-grain=8 --svt tune=0 --svt film-grain-denoise=0"
      filter="--vfilter scale=1920:-2 ''${grain}"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video}  ''${filter} --scd true --cache true --keyint 30s -i"
      fd atmos -E '*720*' -E '*Opus*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "av1-8ch" ''
      video="--pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=256k --enc ac=8"
      # grain="--svt film-grain=8 --svt tune=0 --svt film-grain-denoise=0"
      filter="--vfilter scale=1920:-2 ''${grain}"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video}  ''${filter}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd '7\.1' -E '*720*' -E '*Opus*' -E '*Atmos*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "av1-6ch" ''
      video="--pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=128k --enc ac=6"
      # grain="--svt film-grain=8 --svt tune=0 --svt film-grain-denoise=0"
      filter="--vfilter scale=1920:-2 ''${grain}"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video} ''${filter}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd '5\.1' -E '*720*' -E '*Opus*' -E '*Atmos*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "av1-6ch-film-grain" ''
      video="--pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=128k --enc ac=6"
      grain="--svt film-grain=8 --svt tune=0 --svt film-grain-denoise=0"
      filter="--vfilter scale=1920:-2 ''${grain}"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video} ''${filter} ''${grain} ''${audio} --scd true --cache true --keyint 30s -i"
      fd '5\.1' -E '*720*' -E '*Opus*' -E '*Atmos*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "av1-stereo" ''
      video="--pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=48k --enc ac=2"
      # grain="--svt film-grain=8 --svt tune=0 --svt film-grain-denoise=0"
      filter="--vfilter scale=1920:-2 ''${grain}"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video} ''${filter}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd '2\.0' -E '*720*' -E '*Opus*' -E '*Atmos*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "av1-stereo-film-grain" ''
      video="--pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=48k --enc ac=2"
      grain="--svt film-grain=8 --svt tune=0 --svt film-grain-denoise=0"
      filter="--vfilter scale=1920:-2 ''${grain}"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video} ''${filter} ''${grain} ''${audio} --scd true --cache true --keyint 30s -i"
      fd '2\.0' -E '*720*' -E '*Opus*' -E '*Atmos*' -e mkv -j1 -x ''${av1cmd}
    '')
    # keep atmos audio bc I have an atmos setup
    (writeShellScriptBin "x265-atmos" ''
      x265="-e libx265 --preset medium"
      video="''${x265} --pix-format yuv420p10le"
      scale="--vfilter scale=1920:-2"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video} ''${scale} --scd true --cache true --keyint 30s -i"
      fd atmos -E '*720*' -E '*Opus*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "x265-8ch" ''
      x265="-e libx265 --preset medium"
      video="''${x265} --pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=256k --enc ac=8"
      scale="--vfilter scale=1920:-2"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video} ''${scale} ''${audio} --scd true --cache true --keyint 30s -i"
      fd 7\.1 -E '*720*' -E '*Opus*' -E '*Atmos*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "x265-6ch" ''
      x265="-e libx265 --preset medium"
      video="''${x265} --pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=128k --enc ac=6"
      scale="--vfilter scale=1920:-2"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video} ''${scale}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd 5\.1 -E '*720*' -E '*Opus*' -E '*Atmos*' -e mkv -j1 -x ''${av1cmd}
    '')
    (writeShellScriptBin "x265-stereo" ''
      x265="-e libx265 --preset medium"
      video="''${x265} --pix-format yuv420p10le"
      audio="--acodec libopus --enc b:a=48k --enc ac=2"
      scale="--vfilter scale=1920:-2"
      av1cmd="ab-av1 auto-encode --temp-dir $HOME/.ab-av1 ''${video} ''${scale}  ''${audio} --scd true --cache true --keyint 30s -i"
      fd 2\.0 -E '*720*' -E '*Opus*' -E '*Atmos*' -e mkv -j1 -x ''${av1cmd}
    '')
    (
      writeShellScriptBin "print-bitrates" ''
        #!/usr/bin/env bash

        dir=$(echo $PWD | sed "s/\//_/g")

        echo writing to /tmp/''${dir}-bitrates-sorted.txt
        fd . -0 -E '*Opus*' -e mkv -e mp4 | xargs -0 -I {} sh -c 'echo -n "{}" && ffmpeg -i "{}" 2>&1 | sed -n -e "s/^.*bitrate: /\| /p" ' > /tmp/''${dir}-bitrates.txt
        sort -r -t'|' -k2 -n  < /tmp/''${dir}-bitrates.txt > /tmp/''${dir}-bitrates-sorted.txt
        rm /tmp/''${dir}-bitrates.txt
        echo written.
      ''
    )
  ];
}
