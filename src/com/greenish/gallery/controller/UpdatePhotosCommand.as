/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.controller {
import com.greenish.gallery.events.DataLoaderEvent;
import com.greenish.gallery.interfaces.ICreatorService;
import org.robotlegs.mvcs.Command;

/**
 * Command runs when some pictures were loaded and we need to generate the tree (or just add new one)
 */
public class UpdatePhotosCommand extends Command {
    [Inject]
    public var event:DataLoaderEvent;
    [Inject]
    public var service:ICreatorService;

    /**
     * if we have no id for replace, we should generate tree, otherwise add new photo to tree
     */
    override public function execute():void
    {

       if (event.vo.replaceId == -1) {
           service.generate(event.vo);
       } else {
           service.add(event.vo.items[0],event.vo.replaceId);
       }


    }
}
}
