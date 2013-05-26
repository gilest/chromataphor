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
    # iterate over all the paritions within the preferences
    @preferences.bootPartitions.each do |partition|

      # create a field for the name
      parition_name = NSTextField.alloc.initWithFrame(NSMakeRect(20, yValue, 120, 22))
      parition_name.stringValue = partition[:name]
      parition_name.autoresizingMask = NSViewMinXMargin|NSViewMinYMargin|NSViewWidthSizable
      parition_name.setTag tag
      @prefsWindow.contentView.addSubview(parition_name)

      # and the reference
      partition_reference = NSTextField.alloc.initWithFrame(NSMakeRect(160, yValue, 60, 22))
      partition_reference.stringValue = partition[:reference]
      partition_reference.autoresizingMask = NSViewMinXMargin|NSViewMinYMargin|NSViewWidthSizable
      partition_reference.setTag tag
      @prefsWindow.contentView.addSubview(partition_reference)

      # and a checkbox for enabling/disabling
      partition_enabled = NSButton.alloc.initWithFrame(NSMakeRect(240, yValue, 60, 22))
      partition_enabled.setButtonType(NSSwitchButton)
      partition_enabled.setTitle 'Enabled'
      state = case partition[:enabled]
      when true
        NSOnState
      when false
        NSOffState
      end
      partition_enabled.setState state
      partition_enabled.setTag tag
      @prefsWindow.contentView.addSubview(partition_enabled)

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

end