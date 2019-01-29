class ChordsController < ApplicationController
  def index
    require 'pry'
    #list of chords as FORMULA => NAME
    ingredients = {
  #    November Chords, DADF#ad - checked
          "000xx4" => "D",
         	"44x50x" => "F#-11",
          "5x0x00" => "Gsus2",
          "9000xc" => "B-7",
          "5x05x7" => "Gadd9",
          "4xxx00" => "D/F#",
          "2x0124" => "E-9",
          "2x0120" => "E-7", #no name??
          "x02120" => "E-7/A",
          "x0x112" => "A7(b9)",
          "002000" => "Dadd9",
          "5xx504" => "Gmaj9",
          "5xx574" => "Gmaj13",
          "4xx340" => "Dmaj7/F#",
          "x200x0" => "B-",
          "x00340" => "Dmaj7/A",
          "002000" => "Dadd9",
          "5x0500" => "G",
          "x0x14x" => "A7",
          "440000" => "Dmaj7/F#",
          "440500" => "Dmaj6/F#",
          "x05540" => "A9",
          "x0x122" => "A9",
          "x20020" => "B-",
          "x12xx0" => "Bbo",
          "6x2222" => "E/G#",
          "5x0x20" => "G",
          "2x01x0" => "E-7",
          "x0x1x2" => "A7",
          "002040" => "Dmaj9",
          "0x0344" => "Dmaj7",
          "0xxx54" => "D",
    }

    #establish guitar tuning
    @tuning = ['d', 'a', 'd', 'fs', 'a', 'd']

    #the 12 music notes, initially accidentals represented by sharps
    @notes = ["c", "cs", "d", "ds", "e", "f", "fs", "g", "gs", "a", "as", "b", "c", "cs", "d", "ds", "e", "f", "fs", "g", "gs", "a", "as", "b"]

    #create 6 arrays for all strings based on notes+tuning
    @notes_map_on_string = {
      6 => @notes.rotate(@notes.index(@tuning[0])),
      5 => @notes.rotate(@notes.index(@tuning[1])),
      4 => @notes.rotate(@notes.index(@tuning[2])),
      3 => @notes.rotate(@notes.index(@tuning[3])),
      2 => @notes.rotate(@notes.index(@tuning[4])),
      1 => @notes.rotate(@notes.index(@tuning[5]))
    }

    #roman numeral values for frets
    @roman_values = {
      1 => "I",
      2 => "II",
      3 => "III",
      4 => "IV",
      5 => "V",
      6 => "VI",
      7 => "VII",
      8 => "VIII",
      9 => "IX",
      10 => "X",
      11 => "XI",
      12 => "XII",
      13 => "XIII",
      14 => "XIV",
      15 => "XV",
      16 => "XVI",
      17 => "XVII",
      18 => "XVIII",
      19 => "XIX",
      20 => "XX",
      21 => "XXI",
      22 => "XXII"
    }

    #convert chord formula shorthand a-e into 2-digit integers 10-14
    @pairs = {
      "a" => "10",
      "b" => "11",
      "c" => "12",
      "d" => "13",
      "e" => "14"
    }

    #list of all interval names for every chord root, used for chord spelling
    @all_scales = {
      "c" => {
        "1" => "c",
        "#1" => "cs",
        "b2" => "db",
        "2" => "d",
        "b3" => "eb",
        "3" => "e",
        "4" => "f",
        "#4" => "fs",
        "b5" => "gb",
        "5" => "g",
        "#5" => "gs",
        "b6" => "ab",
        "6" => "a",
        "#6" => "as",
        "b7" => "bb",
        "7" => "b"
        },
      "d" => {
        "1" => "d",
        "#1" => "ds",
        "b2" => "eb",
        "2" => "e",
        "b3" => "f",
        "3" => "fs",
        "4" => "g",
        "#4" => "gs",
        "b5" => "ab",
        "5" => "a",
        "#5" => "as",
        "b6" => "bb",
        "6" => "b",
        "#6" => "bs",
        "b7" => "c",
        "7" => "cs"
      },
      "e" => {
        "1" => "e",
        "#1" => "es",
        "b2" => "f",
        "2" => "fs",
        "b3" => "g",
        "3" => "gs",
        "4" => "a",
        "#4" => "as",
        "b5" => "bb",
        "5" => "b",
        "#5" => "bs",
        "b6" => "c",
        "6" => "cs",
        "#6" => "css",
        "b7" => "d",
        "7" => "ds"
      },
      "f" => {
        "1" => "f",
        "#1" => "fs",
        "b2" => "gb",
        "2" => "g",
        "b3" => "ab",
        "3" => "a",
        "4" => "bb",
        "#4" => "b",
        "b5" => "cb",
        "5" => "c",
        "#5" => "cs",
        "b6" => "db",
        "6" => "d",
        "#6" => "ds",
        "b7" => "eb",
        "7" => "e"
      },
      "g" => {
        "1" => "g",
        "#1" => "gs",
        "b2" => "ab",
        "2" => "a",
        "b3" => "bb",
        "3" => "b",
        "4" => "c",
        "#4" => "cs",
        "b5" => "db",
        "5" => "d",
        "#5" => "ds",
        "b6" => "eb",
        "6" => "e",
        "#6" => "es",
        "b7" => "f",
        "7" => "fs"
      },
      "a" => {
        "1" => "a",
        "#1" => "as",
        "b2" => "bb",
        "2" => "b",
        "b3" => "c",
        "3" => "cs",
        "4" => "d",
        "#4" => "ds",
        "b5" => "eb",
        "5" => "e",
        "#5" => "es",
        "b6" => "f",
        "6" => "fs",
        "#6" => "fss",
        "b7" => "g",
        "7" => "gs"
      },
      "b" => {
        "1" => "b",
        "#1" => "bs",
        "b2" => "c",
        "2" => "cs",
        "b3" => "d",
        "3" => "ds",
        "4" => "e",
        "#4" => "es",
        "b5" => "f",
        "5" => "fs",
        "#5" => "fss",
        "b6" => "g",
        "6" => "gs",
        "#6" => "gss",
        "b7" => "a",
        "7" => "as"
      },
      "bb" => {
        "1" => "bb",
        "#1" => "b",
        "b2" => "cb",
        "2" => "c",
        "b3" => "db",
        "3" => "d",
        "4" => "eb",
        "#4" => "e",
        "b5" => "fb",
        "5" => "f",
        "#5" => "fs",
        "b6" => "gb",
        "6" => "g",
        "#6" => "gs",
        "b7" => "ab",
        "7" => "a"
      },
      "eb" => {
        "1" => "eb",
        "#1" => "e",
        "b2" => "fb",
        "2" => "f",
        "b3" => "gb",
        "3" => "g",
        "4" => "ab",
        "#4" => "a",
        "b5" => "bbb",
        "5" => "bb",
        "#5" => "b",
        "b6" => "cb",
        "6" => "c",
        "#6" => "cs",
        "b7" => "db",
        "7" => "d"
      },
      "ab" => {
        "1" => "ab",
        "#1" => "a",
        "b2" => "bbb",
        "2" => "bb",
        "b3" => "cb",
        "3" => "c",
        "4" => "db",
        "#4" => "d",
        "b5" => "ebb",
        "5" => "eb",
        "#5" => "e",
        "b6" => "fb",
        "6" => "f",
        "#6" => "fs",
        "b7" => "gb",
        "7" => "g"
      },
      "fs" => {
        "1" => "fs",
        "#1" => "fss",
        "b2" => "g",
        "2" => "gs",
        "b3" => "a",
        "3" => "as",
        "4" => "b",
        "#4" => "bs",
        "b5" => "c",
        "5" => "cs",
        "#5" => "css",
        "b6" => "d",
        "6" => "ds",
        "#6" => "dss",
        "b7" => "e",
        "7" => "es"
      },
      "cs" => {
        "1" => "cs",
        "#1" => "css",
        "b2" => "d",
        "2" => "ds",
        "b3" => "e",
        "3" => "es",
        "4" => "fs",
        "#4" => "fss",
        "b5" => "g",
        "5" => "gs",
        "#5" => "gss",
        "b6" => "a",
        "6" => "as",
        "#6" => "ass",
        "b7" => "b",
        "7" => "bs"
      },
      "gs" => {
        "1" => "gs",
        "#1" => "gss",
        "b2" => "a",
        "2" => "as",
        "b3" => "b",
        "3" => "bs",
        "4" => "cs",
        "#4" => "css",
        "b5" => "d",
        "5" => "ds",
        "#5" => "dss",
        "b6" => "e",
        "6" => "es",
        "#6" => "ess",
        "b7" => "fs",
        "7" => "fss"
      }
    }

    #list of all Hub Guitar chord formulas
    @all_formulas = {
      "zzz" => ["1", "b2", "2", "b3", "3", "4", "b5", "5", "b6", "6", "b7", "7"], #chromatic chord, useful for debugging/allows all possibilities
      "maj7" => ["1", "3", "5", "7"],
      "maj9" => ["1", "3", "5", "7", "2"],
      "maj13" => ["1", "3", "5", "7", "2", "6"],
      "maj7(#11)" => ["1", "3", "5", "7", "#4"],
      "maj7b5" => ["1", "3", "b5", "7"],
      "maj7#5" => ["1", "3", "#5", "7"],
      "6" => ["1", "3", "5", "6"],
      "69" => ["1", "3", "5", "6", "2"],
      "7" => ["1", "3", "5", "b7"],
      "7b5" => ["1", "3", "b5", "b7"],
      "+7" => ["1", "3", "#5", "b7"],
      "7#5" => ["1", "3", "#5", "b7"], #the same as the prev
      "9" => ["1", "3", "5", "b7", "2"],
      "7(b9)" => ["1", "3", "5", "b7", "b2"],
      "7(#9)" => ["1", "3", "5", "b7", "#2"],
      "7(#11)" => ["1", "3", "5", "b7", "#4"],
      "13" => ["1", "3", "5", "b7", "2", "6"],
      "7(b13)" => ["1", "3", "5", "b7", "b6"],
      "7sus" => ["1", "4", "5", "b7"],
      "9sus" => ["1", "4", "5", "b7", "2"],
      "-" => ["1", "b3", "5"],
      "-7" => ["1", "b3", "5", "b7"],
      "-9" => ["1", "b3", "5", "b7", "b2"],
      "-11" => ["1", "b3", "5", "b7", "b2", "4"],
      "-6" => ["1", "b3", "5", "6"],
      "-Maj7" => ["1", "b3", "5", "7"],
      "-Maj7(9)" => ["1", "b3", "5", "7", "2"],
      "-7#5" => ["1", "b3", "#5", "b7"],
      "-7b5" => ["1", "b3", "b5", "b7"],
      "o" => ["1", "b3", "b5"],
      "o7" => ["1", "b3", "b5", "bb7"],
      "+" => ["1", "3", "#5"],
      "sus2" => ["1", "2", "5"],
      "sus4" => ["1", "4", "5"],
      "add9" => ["1", "3", "5", "2"],
      "5" => ["1", "5"]
    }

    #list of all enharmonic spellings, used to determine whether a note should be F# or Gb
    @all_enharmonics = {
      "c" => ["c", "bs", "dbb"],
      "cs" => ["cs", "db"],
      "db" => ["db", "cs"],
      "d" => ["d", "css", "ebb"], #rare
      "ds" => ["ds", "eb"],
      "eb" => ["eb", "ds"],
      "e" => ["e", "fb", "dss"],
      "f" => ["f", "es", "gbb"],
      "fs" => ["fs", "gb"],
      "gb" => ["gb", "fs"],
      "g" => ["g", "fss", "abb"], #rare
      "gs" => ["gs", "ab"],
      "ab" => ["ab", "gs"],
      "a" => ["a", "gss", "bbb"], #rare
      "as" => ["as", "bb"],
      "b" => ["b", "cb", "ass"]
    }

    #initialize output of chord
    @chord_display = "".html_safe
    id = 1

    #begin the loop over the entire list of chords as "x32000" => "Cmaj7"
    ingredients.each do |key, value|
      @chord_recipe = key
      @chord_name = value

    #splits chord formula shorthand into an array, "x32010" becomes ["x", "3", "0", "1", "0"]
      def getChordArray(chord)
        if chord.length == 6
          chord_split = chord.chars
          chord_array = chord_split.map do |e|
            e == "a" || e == "b" || e == "c" || e == "d" || e == "e"? @pairs[e] : e
          end
        else
          "Error, please supply 6 notes for the chord."
        end
      end

      #function for use when the fret is higher than 5
      def modifiedChordArray(array)
        array.map { |e| e.to_i != 0 ? (e.to_i - @difference).to_s : e}
      end

      #finds the highest integer.
      def findHighest(array)
        numbers_string_only = array.select { |x| x.to_i }
        numbers_only = numbers_string_only.map { |e| e.to_i}
        numbers_only.max
      end

      #runs the above functions to return an array for chord, highest value, and number of fret label "I"
      @chord_array = getChordArray(@chord_recipe)
      @highest = findHighest(@chord_array)
      @label_fret = @roman_values[1]

      #comparison to choose label fret
      if @highest > 5
        @difference = @highest - 5
        @modified_chord_array = modifiedChordArray(@chord_array)
        @label_fret = @roman_values[@highest - 4]
      else
        @modified_chord_array = @chord_array
      end

      #assign CSS class based on how many characters are in Fret Label: V, VI, VII, VII need different styles
      length = @label_fret.length
      @label_fret_class = "label-fret-#{length}"

      #split the name of the chord into two parts: Root and Quality
      def getRootQuality(chord)
        matchChord = %r{(?<root>[A-G][b#]?)(?<quality>[a-z0-9()b#-]*)(?<slash>/?[A-G]?[b#]?)}.match(chord)
        original_root = matchChord['root']
        cleaned_root = matchChord['root'].gsub('#', 's')
        quality = matchChord['quality']
        slash = matchChord ['slash']

        {'root' => cleaned_root, 'original_root' => original_root, 'quality' => quality, 'slash' => slash}
      end

      #using the ROOT and QUALITY from getRootQuality, we can look up the SPELLING by referencing all_formulas(quality) and comparing that to all_spelling(root)
      def getChordNotes(chord)
        root = getRootQuality(chord)['root'].downcase
        quality = getRootQuality(chord)['quality']
        if @all_formulas[quality]
          formula = @all_formulas[quality]
        else
          formula = ["1", "3", "5"]
        end
        # formula = quality ? @all_formulas[quality] : ["1", "3", "5"]
        # this short hand stopped working for some reason, I changed it to long-hand above
        chord_spelling = []

        formula.each do |formula_item|
          chord_spelling.push(@all_scales[root][formula_item])
        end
        chord_spelling
      end

      @chord_name_array = getRootQuality(@chord_name)
      @chord_spelling_array = getChordNotes(@chord_name)
      #Question: Can chord_spelling array only show the note once if it's repeated?



      #The loop to build the chord HTML starts, runs for every chord in INGREDIENTS array
      @chord_frets = ""
      f = 0
      while f <= 5
        @chord_frets += "\r\n\t\t<div class='fret-row-#{f} flex-frets'>"
          s = 6
          pos = 0
          while s >= 1
            @chord_frets += "\r\n\t\t\t<div class='string-#{s}"

              if f == 0
                if @chord_array[pos] == 'x'
                  @chord_frets += " fill-note fill-note-x"
                elsif @chord_array[pos] == '0'
                  @chord_frets += " fill-note fill-note-#{@tuning[pos]}"
                end
              end

              if @highest <= 5 && @chord_array[pos] == f.to_s

                @fill_me = @notes_map_on_string[s][f]
                #check the notes against the chord_spelling_array
                if !@chord_spelling_array.include?(@fill_me)
                  @all_enharmonics_array = @all_enharmonics[@fill_me]

                  @new_fill_me = @all_enharmonics_array.select {|option| @chord_spelling_array.include?(option)}

                  @fill_me = @new_fill_me.join('')
                end

                @chord_frets += " fill-note fill-note-#{@fill_me}"
              else
                if @modified_chord_array[pos] == f.to_s
                  @fill_me = @notes_map_on_string[s][@chord_array[pos].to_i]
                  @chord_frets += " fill-note fill-note-#{@fill_me}"
                end

              end

            @chord_frets += "'></div>" #close string div
            pos+=1
            s-=1
          end

        @chord_frets += "\r\n\t\t</div>" #close fretrow div
        f+=1
      end

      @chord_display +=
      "\r\n\r\n<div class='chord-wrapper' id='chord-box-#{id}'>\r\n\t<h1 class='chord-name'>".html_safe + @chord_name_array['original_root'].html_safe + "<sup>".html_safe + @chord_name_array['quality'].html_safe + "</sup>".html_safe + @chord_name_array['slash'].html_safe + "</h1>\r\n\t<span class='label-fret #{@label_fret_class}'>".html_safe + @label_fret.html_safe + "</span>".html_safe + "\r\n\t<div class='chord-container'>".html_safe + @chord_frets.html_safe + "\r\n\t</div>\r\n</div>".html_safe

      id += 1
    end

    #Testing Chord Model


  end

end
