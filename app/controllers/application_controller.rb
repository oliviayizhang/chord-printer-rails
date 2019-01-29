class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :create_chord
  require 'pry'

  def create_chord(chord_recipe, chord_name, tuning)
    @chord = Chord.new(chord_recipe, chord_name, tuning)

    @chord_display = "".html_safe
    @chord_frets = "".html_safe


    f = 0

    while f <= 5
      @chord_frets += "\r\n\t\t<div class='fret-row-#{f} flex-frets'>"
      binding.pry
      s = 6
      pos = 0

      while s >= 1
        @chord_frets += "\r\n\t\t\t<div class='string-#{s}"

        if f == 0
          if @chord.chord_array[pos] == 'x'
            @chord_frets += " fill-note fill-note-x"
          elsif @chord.chord_array[pos] == '0'
            @chord_frets += " fill-note fill-note-#{@chord.tuning[pos]}"
          end
        end

        if @chord.highest <= 5 && @chord.chord_array[pos] == f.to_s
          @fill_me = @chord.notes_map_on_string[s][f]
          #check the notes against the chord_spelling_array
          if !@chord.chord_spelling_array.include?(@fill_me)
            @all_enharmonics_array = @chord.all_enharmonics[@fill_me]
            @new_fill_me = @all_enharmonics_array.select {|option| @chord.chord_spelling_array.include?(option)}
            @fill_me = @new_fill_me.join('')
          end

          @chord_frets += " fill-note fill-note-#{@fill_me}"

        elsif  @chord.modified_chord_array[pos] == f.to_s
          @fill_me = @chord.notes_map_on_string[s][@chord.chord_array[pos].to_i]
          @chord_frets += " fill-note fill-note-#{@fill_me}"
        end

      end

      @chord_frets += "'></div>" #close string div
      pos+=1
      s-=1
    end

    @chord_frets += "\r\n\t\t</div>" #close fretrow div
    f+=1

    @chord_display +=
    "\r\n\r\n<div class='chord-wrapper' id='chord-box-1'>\r\n\t<h1 class='chord-name'>".html_safe + @chord.chord_name_array['original_root'].html_safe + "<sup>".html_safe + @chord.chord_name_array['quality'].html_safe + "</sup>".html_safe + @chord.chord_name_array['slash'].html_safe + "</h1>\r\n\t<span class='label-fret #{@chord.label_fret_class}'>".html_safe + @chord.label_fret.html_safe + "</span>".html_safe + "\r\n\t<div class='chord-container'>".html_safe + @chord_frets.html_safe + "\r\n\t</div>\r\n</div>".html_safe

  end
end
