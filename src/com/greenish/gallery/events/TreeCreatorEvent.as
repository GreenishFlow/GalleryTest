/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.events {
import com.greenish.gallery.models.vo.TreeNodeVO;

import flash.events.Event;

public class TreeCreatorEvent extends Event {
    public static const COMPLETE:String = "on complete TreeCreatorEvent";
    private var _data:Vector.<TreeNodeVO>;

    public function TreeCreatorEvent(type:String, data:Vector.<TreeNodeVO>) {
        _data=data;
        super(type, false, true);
    }

    public function get data():Vector.<TreeNodeVO> {
        return _data;
    }
}
}
