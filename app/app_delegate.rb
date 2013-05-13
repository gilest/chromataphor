class AppDelegate

  def applicationDidFinishLaunching(notification)
    # set the app name to an instance variable for easy access
    @appName = NSBundle.mainBundle.infoDictionary['CFBundleName']
    # create a new instance of the prefs controller, which also builds the window itself
    @prefsController = PrefsController.new
    # finally, build our status menu itself
    buildStatusMenu
  end

end