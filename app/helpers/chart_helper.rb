module ChartHelper
  include Hasher
  # For more information about OpenFlashChart2Plugin check out the Github repository
  # http://github.com/korin/open_flash_chart_2_plugin
  
  def flash_chart data_url, opts={}
    width  = opts[:width] ? opts[:width] : 680
    height = opts[:height] ? opts[:height] : 400
    base          = ""
    flash_base    = "/flash/"
    # and now render the flash object
    open_flash_chart_2(width, height, data_url, base, generate_hash(data_url), flash_base)
  end
  
end
