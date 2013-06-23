class AppDelegate

  def buildPrefsWindow

    # create the window and set it up
    @prefsWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
       styleMask: NSTitledWindowMask|NSClosableWindowMask,
       backing: NSBackingStoreBuffered,
       defer: true)
    @prefsWindow.setReleasedWhenClosed(false)
    @prefsWindow.delegate = self
    @prefsWindow.title = "#{@appName} Preferences"

    buildParitionList

    # create a save button and attach it to the bottom of the window
    save_button = NSButton.alloc.initWithFrame(NSMakeRect(240, 20, 60, 25))
    save_button.setBezelStyle NSRoundedBezelStyle
    save_button.setTitle 'Save'
    save_button.setAction 'savePreferences:'
    @prefsWindow.contentView.addSubview(save_button)

  end

  def buildParitionList
    # yValue seems to be the location in pixels from the bottom of the window, so we decrement as we add lines
    yValue = 318
    # tag for assigning ints to NSControl objects so that we can group their values when we save
    tag = 0

    # create field lables for columns
    addLabel 'Partition name', 20, yValue, 120, 22
    addLabel 'Reference', 160, yValue, 80, 22
    addLabel 'Enabled', 260, yValue, 60, 22

    # decrement the yValue for the next row
    yValue = yValue - 26

    # iterate over all the paritions within the preferences
    @preferences.bootPartitions.each do |partition|

      # and add fields for them
      addTextField partition[:name],      tag, 20,  yValue, 120, 22
      addTextField partition[:reference], tag, 160, yValue, 80,  22
      addCheckbox  partition[:enabled],   tag, 260, yValue, 60,  22

      # decrement the yValue for the next row
      yValue = yValue - 26
      # inrement the tag for the next row
      tag = tag + 1
    end
  end

  def savePreferences(sender)

    # load all of the pref window subviews into an object so that we can make sense of them
    @bootPartitionFields = @prefsWindow.contentView.subviews.group_by(&:tag)

    # remove the save button. i can refactor out the need to do this later
    # by putting all the partition forms in a subview
    @bootPartitionFields.delete(-1)

    # initialize a new array to satisfy our preferences storage format
    @bootPartitionValues = []

    # for each grouped set of NSControls in our hash, we can create a nice tidy preference item 
    @bootPartitionFields.each_value do |fields|
      @bootPartitionValues << { name: fields[0].objectValue, reference: fields[1].objectValue, enabled: fields[2].objectValue, current: false }
    end

    puts @bootPartitionValues

    # set and syncronise the preferences
    @preferences.bootPartitions = @bootPartitionValues
    @preferences.sync

  end

  private

  def addLabel(text, x, y, w, h)
    label = NSTextField.alloc.initWithFrame(NSMakeRect(x, y, w, h))
    label.stringValue = text
    label.setBezeled(false)
    label.setDrawsBackground(false)
    label.setEditable(false)
    label.setSelectable(false)
    label.autoresizingMask = NSViewMinXMargin|NSViewMinYMargin|NSViewWidthSizable
    @prefsWindow.contentView.addSubview(label)
  end

  def addTextField(value, tag, x, y, w, h)
    field = NSTextField.alloc.initWithFrame(NSMakeRect(x, y, w, h))
    field.stringValue = value
    field.autoresizingMask = NSViewMinXMargin|NSViewMinYMargin|NSViewWidthSizable
    field.setTag tag
    @prefsWindow.contentView.addSubview(field)
  end

  def addCheckbox(value, tag, x, y, w, h)
    partition_enabled = NSButton.alloc.initWithFrame(NSMakeRect(x, y, w, h))
    partition_enabled.setButtonType(NSSwitchButton)
    partition_enabled.setTitle 'Enabled'
    state = case value
    when true
      NSOnState
    when false
      NSOffState
    end
    partition_enabled.setState state
    partition_enabled.setTag tag
    @prefsWindow.contentView.addSubview(partition_enabled)
  end

end