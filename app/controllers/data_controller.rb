class DataController < SecurityController
  layout 'data'

  def view
    @data = <<-EOS
[{
    title: 'Combination Examples',
    samples: [{
        text: 'Feed Viewer',
        url:  'feed-viewer/view.html',
        icon: 'feeds.gif',
        desc: 'RSS feed reader example application that features a swappable reader panel layout.'
    },{
        text: 'Web Desktop',
        url:  'desktop/desktop.html',
        icon: 'desktop.gif',
        desc: 'Demonstrates how one could build a desktop in the browser using Ext components including a module plugin system.'
    }/*,{
        text: 'Image Organizer',
        url:  'image-organizer/index.html',
        icon: 'image-organizer.gif',
        desc: 'Image management application example utilizing MySQL lite and Ext.Direct.',
        status: 'new'
    }*/,{
        text: 'Ext JS API Documentation',
        url:  '../docs/index.html',
        icon: 'docs.gif',
        desc: 'API Documentation application.',
        status: 'updated'
    },{
        text: 'Ext JS Forum Browser',
        url:  'forum/forum.html',
        icon: 'forum.gif',
        desc: 'Ext JS online forums browser application.',
        status: 'modified'
    },{
        text: 'Image Viewer',
        url:  'organizer/organizer.html',
        icon: 'organizer.gif',
        desc: 'DataView and TreePanel example that demonstrates dragging data items from a DataView into a TreePanel.'
    }]
},{
    title: 'Offline Support',
    samples: [{
        text: 'Simple Tasks',
        url:  'tasks/tasks.html',
        icon: 'tasks.gif',
        desc: 'Personal task management application example that uses <a href="http://gears.google.com" target="_blank">Google Gears</a> for data storage.'
    },{
        text: 'Simple Tasks',
        url:  'http://extjs.com/blog/2008/02/24/tasks2/',
        icon: 'air.gif',
        desc: 'Complete personal task management application example that runs on <a href="http://labs.adobe.com/technologies/air/" target="_blank">Adobe AIR</a>.'
    }]
}]
    EOS

    respond_to do |format|
      format.json { render :json => @data }
    end
  end

  def index
  end
end
