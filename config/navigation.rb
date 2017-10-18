# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  # Specify a custom renderer if needed.
  # The default renderer is SimpleNavigation::Renderer::List which renders HTML lists.
  # The renderer can also be specified as option in the render_navigation call.
  # navigation.renderer = Your::Custom::Renderer

  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  # navigation.selected_class = 'your_selected_class'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  # navigation.active_leaf_class = 'your_active_leaf_class'

  # Item keys are normally added to list items as id.
  # This setting turns that off
  # navigation.autogenerate_item_ids = false

  # You can override the default logic that is used to autogenerate the item ids.
  # To do this, define a Proc which takes the key of the current item as argument.
  # The example below would add a prefix to each key.
  # navigation.id_generator = Proc.new {|key| "my-prefix-#{key}"}

  # If you need to add custom html around item names, you can define a proc that will be called with the name you pass in to the navigation.
  # The example below shows how to wrap items spans.
  # navigation.name_generator = Proc.new {|name| "<span>#{name}</span>"}

  # The auto highlight feature is turned on by default.
  # This turns it off globally (for the whole plugin)
  #navigation.auto_highlight = false

  # Define the primary navigation
  navigation.items do |primary|
    # Add an item to the primary navigation. The following params apply:
    # key - a symbol which uniquely defines your navigation item in the scope of the primary_navigation
    # name - will be displayed in the rendered navigation. This can also be a call to your I18n-framework.
    # url - the address that the generated item links to. You can also use url_helpers (named routes, restful routes helper, url_for etc.)
    # options - can be used to specify attributes that will be included in the rendered navigation item (e.g. id, class etc.)
    #           some special options that can be set:
    #           :if - Specifies a proc to call to determine if the item should
    #                 be rendered (e.g. <tt>:if => Proc.new { current_user.admin? }</tt>). The
    #                 proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :unless - Specifies a proc to call to determine if the item should not
    #                     be rendered (e.g. <tt>:unless => Proc.new { current_user.admin? }</tt>). The
    #                     proc should evaluate to a true or false value and is evaluated in the context of the view.
    #           :method - Specifies the http-method for the generated link - default is :get.
    #           :highlights_on - if autohighlighting is turned off and/or you want to explicitly specify
    #                            when the item should be highlighted, you can set a regexp which is matched
    #                            against the current URI.  You may also use a proc, or the symbol <tt>:subpath</tt>. 
    #
    
    # Highlight the home tab either if the path is / or /home. We only really
    # need this if there are alternative paths that map to the tab, since
    # a url of say /users will automatically map to the users tab and make it
    # highlighted. Note, that we changed the root url to point at the
    # users controller in routes.rb. So for the url '/' you will see the home
    # tab highlighted, even though it's the users being shown! Later on when
    # we have a home controller we can change root to go to the home controller
    # instead.
    # We use a regular expression match expression that either returns true or false
    # Remember that ^ means the start of the url string and $ the end, and the
    # | means or. So matches either / or a url /home
    # Note that highlights_on: is one of many possible options expressed as a
    # hash table. It could have been written like {highlights_on:/(^\/$)|(^\/home$)/}
    # but normally if the hash table is the last parameter of the method
    # call then we can leave off the braces (it is not ambiguous)
    primary.item :home, 'Home', '/home', highlights_on: /(^\/$)|(^\/home$)/
    primary.item :jobs, 'Jobs', '/jobs'
    # The following three tabs should only be displayed if the current user
    # is logged in as an admin. The is_admin? method is defined in application_controller.rb
    # in the controllers folder. At the moment it always returns true, but in later
    # versions it will depend on who is logged in. We want the method to be called
    # every time the layout page is redisplayed since the admin might have logged out
    # or in between refreshed of the page. We need to provide the if: option with
    # a Proc object as its value. This is how we can wrap up a ruby block as an object.
    # We cannot use do ... end here or { ... } here to define the block as an argument to
    # to if:, rather, we have to give it an object. So Proc.new creates that object that wraps
    # up the ruby block { is_admin? }. Notice that no block parameters were required.
    # We use {...} instead of do ... end because the result of the block is important,
    # i.e. that it returns true or false. Try doinging something similar in IRB, e.g.
    # create a is_admin? function and then:
    # p = Proc.new { is_admin? }
    # p.call
    primary.item :profile, 'Profile', '/profile', if: Proc.new { is_admin? }
    primary.item :users, 'Users', users_path, if: Proc.new { is_admin? }
    primary.item :broadcasts, 'Broadcasts', '/broadcasts', if: Proc.new { is_admin? }

    # Add an item which has a sub navigation (same params, but with block)
    #primary.item :key_2, 'name', url, options do |sub_nav|
      # Add an item to the sub navigation (same params again)
      #sub_nav.item :key_2_1, 'name', url, options
    #end

    # You can also specify a condition-proc that needs to be fullfilled to display an item.
    # Conditions are part of the options. They are evaluated in the context of the views,
    # thus you can use all the methods and vars you have available in the views.
    #primary.item :key_3, 'Admin', url, :class => 'special', :if => Proc.new { current_user.admin? }
    #primary.item :key_4, 'Account', url, :unless => Proc.new { logged_in? }

    # you can also specify a css id or class to attach to this particular level
    # works for all levels of the menu
    # primary.dom_id = 'menu-id'
    # primary.dom_class = 'menu-class'

    # You can turn off auto highlighting for a specific level
    # primary.auto_highlight = false

  end

end
