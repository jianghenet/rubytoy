#Vehicle official identification number

class ChinaVion
  PLACES = %w[ 京 津 冀 晋 蒙 辽 吉 黑 沪 苏 浙 皖 闽 赣 鲁 豫 鄂 湘 粤 桂 琼 渝 蜀 贵 滇 藏 秦 甘 青 宁 新 港 澳 台 ]
  TITLES = ('A' .. 'Z').to_a
  ALPHAS = ["A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
  NUMS = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
  MIXS = ALPHAS + NUMS

  def self.generate
    "#{PLACES.sample}#{TITLES.sample}#{MIXS.sample}#{MIXS.sample}#{MIXS.sample}#{MIXS.sample}#{MIXS.sample}"
  end
end

puts ChinaVion.generate
