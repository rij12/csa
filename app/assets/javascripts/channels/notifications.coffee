App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
# Called when the subscription is ready for use on the server

  disconnected: ->
# Called when the subscription has been terminated by the server

  received: (data) ->
# Handle cases where the user has no uploaded photo
    if data.user.image.length > 0
      altText = "Image of #{data.user.firstname} #{data.user.surname}"
    else
      altText = "No photo available"
      data.user.image = "/assets/blank-cover_small.png"

    newNotificationElem = """
        <div class="notification">
            <div class="left">
                <a href="/users/#{data.user.id}">
                    <img class="image-tag" alt="#{altText}"
                        title="#{altText}" src="#{data.user.image}" border="0" />
                </a>
            </div>
            <div class="right">
                <div class="user">
                    <a href="/users/#{data.user.id}">
                        #{data.user.firstname} #{data.user.surname}
                    </a>
                </div>
                <div class="timestamp">
                    <a href="/broadcasts/#{data.id}">
                        #{data.timestamp}
                    </a>
                </div>
                <div class="content">#{data.content}</div>
            </div>
            <br style="clear: both" />
        </div>
    """

    # Add the new broadcast to the top of the list
    $("#notification_feed").prepend(newNotificationElem);
