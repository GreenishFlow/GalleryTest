/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.models {
import com.greenish.gallery.models.vo.TreeNodeVO;
import org.robotlegs.mvcs.Actor;

/**
 * Main model that holds the TreeNodeVO vector
 */
public class SmartGalleryModel extends Actor {


    private var _nodes:Vector.<TreeNodeVO>;

    public function SmartGalleryModel() {
        super();
    }


    public function get nodes():Vector.<TreeNodeVO> {
        return _nodes;
    }

    public function set nodes(value:Vector.<TreeNodeVO>):void {
        _nodes = value;
    }
}
}
