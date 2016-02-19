/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.models.vo {
public class DimensionsVO {
    private var _width:Number=-1;
    private var _height:Number=-1;

    public function get width():Number {
        return _width;
    }

    public function set width(value:Number):void {
        _width = value;
    }

    public function get height():Number {
        return _height;
    }

    public function set height(value:Number):void {
        _height = value;
    }
}
}
