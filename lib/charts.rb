module Charts
  
  def self.included(base)
    # Alias the ugly method name to something more sensible
    # and send as a helper to the view.
    base.send :alias_method, :open_flash_chart_2, :ofc2
    base.send :helper_method, :open_flash_chart_2
  end
  
  CHART_BACKGROUND_COLOUR = "#EFEFEF"
  
  # ----------------------------------------------------------
  # NOTE:
  # Each of these methods assume that "values" is an
  # array of hashes each containing "value" and "label" keys.
  # ----------------------------------------------------------
  
  def build_pie_chart(values, tooltip_content='#val#<br>#percent# of 100%', title=nil)
    pie_data = []
    
    values.each do |set|
      pie_data << OFC2::PieValue.new(set)
    end
    
    # Create the pie
    pie = OFC2::Pie.new
    pie.gradient_fill = true
    pie.alpha         = 0.8
    pie.start_angle   = 35
    pie.animate       =  [OFC2::PieFade.new, OFC2::PieBounce.new]
    pie.label_colour  = '#222222'
    pie.values        = pie_data
    pie.colours       = ["#0095D9", "#A8E04B"]
    pie.tip           = tooltip_content
    
    build_chart(pie)
  end
  
  def build_line_chart(values, tooltip_content='#val#<br>#percent# of 100%', title=nil)
    line_data   = []
    line_labels = []
    counter     = 0
    
    values.reverse.each do |set|
      line_data   << OFC2::SolidDot.new(:value => (counter += set[:value]), :tip => tooltip_content)
      line_labels << set[:label].strftime("%d %B")
    end
    
    line           = OFC2::Line.new
    line.values    = line_data
    line.colour    = "#0095D9"
    line.text      = title
    line.font_size = 12
    
    dot           = OFC2::Dot.new
    dot.colour    = '#0095D9'
    dot.dot_size  = 6
    dot.halo_size = 4
    
    line.dot_style = dot
    
    # Create axis
    axis_options = {
      :colour => "#555555",
      :grid_colour => "#CCCCCC",
      :offset => true,
      :stroke => 2,
      :tick_height => 10
    }
    
    y = OFC2::YAxis.new(axis_options)
    y.max   = counter + 6
    y.steps = counter / 4
    
    x_labels        = OFC2::XAxisLabels.new
    x_labels.size   = 12
    x_labels.rotate = "vertical"
    x_labels.labels = line_labels
    
    x        = OFC2::XAxis.new(axis_options)
    x.labels = x_labels
    
    chart         = build_chart(line)
    chart.y_axis  = y
    chart.x_axis  = x
    chart.tooltip = build_tooltip(true)
    chart
  end
  
  def build_bar_chart(values, tooltip_content='#val#<br>#percent# of 100%', title=nil)
    bar_data   = []
    bar_labels = []
    max_value  = 0
    
    values.reverse.each do |set|
      bar_data   << set[:value]
      bar_labels << set[:label]
      max_value  = set[:value] if set[:value] > max_value
    end
    
    bar        = OFC2::BarGlass.new
    bar.text   = title
    bar.colour = '#10A250'
    bar.values = bar_data
    bar.tip    = tooltip_content
    
    # Create axis
    axis_options = {
      :colour => "#555555",
      :grid_colour => "#CCCCCC",
      :offset => true,
      :stroke => 2,
      :tick_height => 10
    }
    
    y = OFC2::YAxis.new(axis_options)
    y.max   = max_value + (max_value / 100 * 10)
    y.steps = (max_value / 5)
    
    x_labels        = OFC2::XAxisLabels.new
    x_labels.size   = 12
    x_labels.rotate = "vertical"
    x_labels.labels = bar_labels
    
    x        = OFC2::XAxis.new(axis_options)
    x.labels = x_labels
    
    chart = build_chart(bar)
    chart.y_axis  = y
    chart.x_axis  = x
    chart.tooltip = build_tooltip(true)
    chart
  end
  
  protected
  def build_chart chart_content=nil, title=nil
    return unless chart_content
    
    chart           = OFC2::Graph.new
    chart.title     = title
    chart.tooltip   = build_tooltip
    chart.bg_colour = CHART_BACKGROUND_COLOUR
    chart           << chart_content
    chart
  end
  
  def build_tooltip no_title=false, border_colour="#3DC154", background_colour="#FFFFFF"
    tooltip = OFC2::Tooltip.new
    tooltip.hover
    tooltip.stroke            = 2
    tooltip.shadow            = false
    tooltip.colour            = border_colour
    tooltip.background_colour = background_colour
    
    if no_title
      tooltip.title             = "{font-size: 14px; font-weight: bold; color: #111111;}"
      tooltip.body              = "{font-size: 14px; font-weight: bold; color: #111111;}"
    else
      tooltip.title             = "{font-size: 14px; font-weight: bold; color: #111111;}"
      tooltip.body              = "{font-size: 12px; font-weight: bold; color: #707070;}"
    end
    
    tooltip
  end
  
end
