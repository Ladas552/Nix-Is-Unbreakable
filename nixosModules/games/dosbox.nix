{
  pkgs,
  config,
  lib,
  meta,
  ...
}:

{
  options.custom.games = {
    dosbox.enable = lib.mkEnableOption "enable dosbox";
  };

  config = lib.mkIf config.custom.games.dosbox.enable {
    home-manager.users."${meta.user}" = {
      home.packages = [ pkgs.dosbox ];
      home.file.".dosbox/dosbox-0.74-3.conf" = {
        enable = true;
        recursive = true;
        text = ''
          [sdl]
          fullscreen=true
          fulldouble=false
          fullresolution=original
          windowresolution=original
          output=surface
          autolock=true
          sensitivity=100
          waitonerror=true
          priority=higher,normal
          mapperfile=mapper-0.74-3.map
          usescancodes=true
          language=
          machine=svga_s3
          captures=capture
          memsize=16

          [render]
          frameskip=0
          aspect=false
          scaler=normal2x

          [cpu]
          core=auto
          cputype=auto
          cycles=auto
          cycleup=10
          cycledown=20

          [mixer]
          nosound=false
          rate=44100
          blocksize=1024
          prebuffer=25

          [midi]
          mpu401=intelligent
          mididevice=default
          midiconfig=

          [sblaster]
          sbtype=sb16
          sbbase=220
          irq=7
          dma=1
          hdma=5
          sbmixer=true
          oplmode=auto
          oplemu=default
          oplrate=44100

          [gus]
          gus=false
          gusrate=44100
          gusbase=240
          gusirq=5
          gusdma=3
          ultradir=C:\ULTRASND

          [speaker]
          pcspeaker=true
          pcrate=44100
          tandy=auto
          tandyrate=44100
          disney=true

          [joystick]
          joysticktype=auto
          timed=true
          autofire=false
          swap34=false
          buttonwrap=false

          [serial]
          serial1=dummy
          serial2=dummy
          serial3=disabled
          serial4=disabled

          [dos]
          xms=true
          ems=true
          umb=true
          keyboardlayout=auto

          [ipx]
          ipx=false

          [autoexec]
          mount c ~/Games/DOSGAMES
          c:
          dir
        '';

      };
    };
  };
}
