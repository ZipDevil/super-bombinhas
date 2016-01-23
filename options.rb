require_relative 'form'

class Options
  class << self
    def initialize
      @controls = [
        [Gosu::KbUp, Gosu::KbRight, Gosu::KbDown, Gosu::KbLeft, Gosu::KbSpace, Gosu::KbA, Gosu::KbLeftShift, Gosu::KbS],
        [Gosu::KbW, Gosu::KbD, Gosu::KbS, Gosu::KbA, Gosu::KbJ, Gosu::KbK, Gosu::KbL, Gosu::KbI]
      ]
    end

    def form=(form)
      @form = form
    end

    def set_temp
      @lang = SB.lang
      @sound_volume = SB.sound_volume
      @music_volume = SB.music_volume
      @controls_opt = SB.key[:up] == Gosu::KbUp ? 0 : 1
      set_controls_text
    end

    def set_controls_text
      @controls_text.text = SB.text("controls_#{@controls_opt}".to_sym)
    end

    def get_menu
      @menu = [
        MenuButton.new(550, :save, false, 219) {
          SB.save_options(@controls[@controls_opt])
          @form.go_to_section 0
        },
        MenuButton.new(550, :cancel, true, 409) {
          SB.lang = @lang
          SB.sound_volume = @s_v_text.num = @sound_volume
          SB.music_volume = @m_v_text.num = @music_volume
          @form.go_to_section 0
        },
        MenuText.new(:language, 20, 200),
        MenuText.new(:lang_name, 590, 200, 320, :center),
        MenuArrowButton.new(400, 192, 'Left') {
          SB.change_lang(-1)
          set_controls_text
        },
        MenuArrowButton.new(744, 192, 'Right') {
          SB.change_lang
          set_controls_text
        },
        MenuText.new(:sound_volume, 20, 270),
        (@s_v_text = MenuNumber.new(SB.sound_volume, 590, 270, :center)),
        MenuArrowButton.new(400, 262, 'Left') {
          SB.change_volume('sound', -1)
          @s_v_text.num = SB.sound_volume
        },
        MenuArrowButton.new(744, 262, 'Right') {
          SB.change_volume('sound')
          @s_v_text.num = SB.sound_volume
        },
        MenuText.new(:music_volume, 20, 340),
        (@m_v_text = MenuNumber.new(SB.music_volume, 590, 340, :center)),
        MenuArrowButton.new(400, 332, 'Left') {
          SB.change_volume('music', -1)
          @m_v_text.num = SB.music_volume
        },
        MenuArrowButton.new(744, 332, 'Right') {
          SB.change_volume('music')
          @m_v_text.num = SB.music_volume
        },
        MenuText.new(:controls, 20, 410),
        (@controls_text = MenuText.new(:controls, 590, 410, 320, :center)),
        MenuArrowButton.new(400, 402, 'Left') {
          @controls_opt -= 1
          @controls_opt = 1 if @controls_opt < 0
          set_controls_text
        },
        MenuArrowButton.new(744, 402, 'Right') {
          @controls_opt += 1
          @controls_opt = 0 if @controls_opt > 1
          set_controls_text
        }
      ] if @menu.nil?
      @menu
    end
  end
end