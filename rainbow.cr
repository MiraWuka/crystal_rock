# ===============================================================
# RAINBOW ASCII ART — Animated Terminal Banner in Crystal
#
# Author: Mira (15 y.o. DevOps / Go / Crystal enthusiast)
# GitHub: https://github.com/MiraWuka/crystal_rock
# Description:
#   A clean animated ASCII art engine for terminal output, using
#   colorized characters, frame-based rendering, and ANSI control.
#
# Note:
#   Built as a learning and aesthetic project — optimized for fun,
#   but structured with production-level quality and discipline.
# ===============================================================

# Rainbow ASCII Art with Animation — production-level clarity and comments only!

require "colorize"

class RainbowArt
  # Define ANSI-compatible color sequence for dynamic coloring.
  COLORS = [
    :red, :light_red,
    :yellow, :light_yellow,
    :green, :light_green,
    :cyan, :light_cyan,
    :blue, :light_blue,
    :magenta, :light_magenta
  ]

  # Main ASCII banner to render. Keep lines consistent in width.
  ASCII_ART = [
    "    ████████╗██████╗ ██╗   ██╗███████╗████████╗ █████╗ ██╗     ",
    "    ██╔═════╝██╔══██╗╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔══██╗██║     ",
    "    ██║     ██████╔╝ ╚████╔╝ ███████╗   ██║   ███████║██║     ",
    "    ██║     ██╔══██╗  ╚██╔╝  ╚════██║   ██║   ██╔══██║██║     ",
    "    ╚██████╗██║  ██║   ██║   ███████║   ██║   ██║  ██║███████╗",
    "     ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝",
    "",
    "           ██████╗  ██████╗  ██████╗██╗  ██╗███████╗",
    "           ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝",
    "           ██████╔╝██║   ██║██║     █████╔╝ ███████╗",
    "           ██╔══██╗██║   ██║██║     ██╔═██╗ ╚════██║",
    "           ██║  ██║╚██████╔╝╚██████╗██║  ██╗███████╗",
    "           ╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝",
  ]

  # Decorative stars rendered above and below the banner.
  STAR_PATTERN = [
    "                    ✦       ✧        ★       ✦           ",
    "          ★              ✦       ✧         ✦      ★     ",
    "     ✧         ★    ✦              ★           ✧        ",
    "                ✦       ★       ✧        ✦              ",
  ]

  def initialize
    @frame = 0
    @running = true
    setup_signal_handler
  end

  private def setup_signal_handler
    # Gracefully handle Ctrl+C interrupt
    Signal::INT.trap do
      @running = false
    end
  end

  def clear_screen
    # ANSI escape sequence to clear terminal
    print "\033[2J\033[H"
  end

  # Print a single ASCII line with rainbow effect based on index offset.
  def rainbow_line(line : String, offset : Int32)
    line.each_char_with_index do |char, index|
      if char != ' '
        color_index = (index + offset) % COLORS.size
        print char.to_s.colorize(COLORS[color_index])
      else
        print char
      end
    end
    puts ""
  end

  # Same as above, but for decorative stars.
  def rainbow_stars(offset : Int32)
    star_line = STAR_PATTERN[@frame % STAR_PATTERN.size]
    star_line.each_char_with_index do |char, index|
      if char != ' '
        color_index = (index + offset) % COLORS.size
        print char.to_s.colorize(COLORS[color_index])
      else
        print char
      end
    end
    puts ""
  end

  def render_frame
    clear_screen
    
    # Top border of stars
    rainbow_stars(@frame * 2)
    puts ""

    # Main art body
    ASCII_ART.each_with_index do |line, index|
      rainbow_line(line, @frame + index * 3)
    end

    puts ""

    # Bottom border of stars
    rainbow_stars(@frame * -1)

    # Frame meta info (can be hidden in production mode)
    puts ""
    puts "#{" " * 15}🌈 CRYSTAL RAINBOW ENGINE 🌈".colorize(:white)
    puts "#{" " * 20}Frame: #{@frame}".colorize(:light_gray)
    puts ""
    puts "#{" " * 12}Press Ctrl+C to exit...".colorize(:light_gray)
  end

  def animate
    puts "Launching animation engine... 🌈"
    sleep(1.second)
    
    while @running
      render_frame
      @frame += 1
      sleep(150.milliseconds) # Adjust for performance on slow terminals
    end

    # Final screen on graceful exit
    clear_screen
    puts ""
    puts "#{" " * 20}🌈 Thanks for watching 🌈".colorize(:magenta)
    puts "#{" " * 15}Crystal rocks! ✨".colorize(:cyan)
    puts ""
  end
end

# A simple rainbow progress bar utility — useful for fake loading screens.
class ProgressBar
  def self.rainbow_progress(percentage : Int32)
    bar_length = 40
    filled = (bar_length * percentage / 100).to_i

    print "Rainbow Load: ["
    (0...bar_length).each do |i|
      if i < filled
        color = RainbowArt::COLORS[i % RainbowArt::COLORS.size]
        print "█".colorize(color)
      else
        print "░".colorize(:light_gray)
      end
    end
    puts "] #{percentage}%"
  end
end

# Main program startup sequence
puts "🌈 RAINBOW ASCII ART 🌈".colorize(:white)
puts "=" * 50

# Show fake loading progress
(0..100).step(5) do |i|
  print "\033[2J\033[H"
  puts ""
  puts "🌈 Initializing rainbow engine... 🌈".colorize(:cyan)
  puts ""
  ProgressBar.rainbow_progress(i)
  sleep(100.milliseconds)
end

sleep(500.milliseconds)

# Start the animation
rainbow_art = RainbowArt.new
rainbow_art.animate

