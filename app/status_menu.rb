class AppDelegate

  def buildStatusMenu

    # create status item object
    @statusItem = createStatusItem()
    # set its title
    @statusItem.setTitle("C")
    # set highlitght mode
    @statusItem.setHighlightMode(true)

    # build a menu for it
    @statusMenu = NSMenu.alloc.initWithTitle(@appName)

    # reboot to os menu items - they do nothing right now
    item = NSMenuItem.alloc.initWithTitle('Reboot to OS X', action: '', keyEquivalent: '')
    @statusMenu.addItem item

    item = NSMenuItem.alloc.initWithTitle('Reboot to Windows', action: '', keyEquivalent: '')
    @statusMenu.addItem item

    item = NSMenuItem.alloc.initWithTitle('Reboot to Linux', action: '', keyEquivalent: '')
    @statusMenu.addItem item

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

  private

  def createStatusItem
    statusItem = NSStatusBar.systemStatusBar.statusItemWithLength(NSVariableStatusItemLength).retain
    statusItem
  end

  def showPreferences
    @prefsController.show
  end

  def showAbout
    NSApp.orderFrontStandardAboutPanel(true)
    NSApp.activateIgnoringOtherApps(true)
  end

end
