# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/osx'
require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.copyright = "Copyright © 2013 Giles Thompson. All Right Reserved."
  app.identifier = 'co.nz.gilesthompson.Chromataphor'
  app.name = 'Chromataphor'
  app.version = '0.0.1'
  # hides dock icon and allows app to run in the background
  app.info_plist['LSUIElement'] = 1
end