class AppDelegate

  def buildStatusMenu

    # create status item object
    @statusItem = createStatusItem()
    # set its image
    path = NSBundle.mainBundle.pathForResource("icon16", ofType:"png")
    image = NSImage.alloc.initWithContentsOfFile(path)
    @statusItem.setImage(image)
    # set highlitght mode
    @statusItem.setHighlightMode(true)

    # build a menu for it
    @statusMenu = NSMenu.alloc.initWithTitle(@appName)

    # separator
    @statusMenu.addItem NSMenuItem.separatorItem

    # launch the preferences
    item = NSMenuItem.alloc.initWithTitle('Preferences...', action: 'showPreferences', keyEquivalent: '')
    @statusMenu.addItem item

    # open the about panel
    item = NSMenuItem.alloc.initWithTitle("About #{@appName}", action: 'showAbout', keyEquivalent: '')
    @statusMenu.addItem item

    # quit the app
    item = NSMenuItem.alloc.initWithTitle("Quit", action: 'terminate:', keyEquivalent: '')
    @statusMenu.addItem item

    # set the built menu to the status item object
    @statusItem.setMenu(@statusMenu)

  end

  def updatePartitionsInMenu

    # initialize partition menu items array if empty
    @partitionMenuItems ||= []

    # remove all previously added items
    @partitionMenuItems.each do |menuItem|
      @statusMenu.removeItem menuItem
    end

    # clear it out so that we're starting fresh
    @partitionMenuItems = []

    # if there are no user added partitions eg. on a fresh launch
    if @preferences.bootPartitions.empty?
      item = NSMenuItem.alloc.initWithTitle("Add your partitions...", action: 'showPreferences', keyEquivalent: '')
      item.setTag 5
      @partitionMenuItems << item
      @statusMenu.insertItem item, atIndex: 0
    else
      # programatically build and add users boot partitions from their preferences file
      @preferences.bootPartitions.reverse.each do |partition|
        if partition[:enabled]
          item = NSMenuItem.alloc.initWithTitle("Reboot to #{partition[:name]}", action: 'rebootTo:', keyEquivalent: '')
          item.setRepresentedObject partition
          item.setTag 5
          @partitionMenuItems << item
          @statusMenu.insertItem item, atIndex: 0
        end
      end
    end
    
  end

  private

  def createStatusItem
    statusItem = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength).retain
    statusItem
  end

  def rebootTo(sender)
    partition = sender.representedObject
    @bootPlist.defaultPartition = partition[:reference]
    @bootPlist.save
  end

  def showPreferences
    @prefsWindow.makeKeyAndOrderFront(self)
    NSApp.activateIgnoringOtherApps(true)
  end

  def showAbout
    NSApp.orderFrontStandardAboutPanel(true)
    NSApp.activateIgnoringOtherApps(true)
  end

end
