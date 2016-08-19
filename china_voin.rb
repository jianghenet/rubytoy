#Vehicle official identification number

class ChinaVion
  PLACES = %w[ 京 津 冀 晋 蒙 辽 吉 黑 沪 苏 浙 皖 闽 赣 鲁 豫 鄂 湘 粤 桂 琼 渝 蜀 贵 滇 藏 秦 甘 青 宁 新 港 澳 台 ]
  TITLES = ('A' .. 'Z').to_a

  def self.generate
    "#{PLACES.sample}#{TITLES.sample} #{(rand(36**5) + 1).to_s(36).rjust(5, '0').upcase}"
  end
end

