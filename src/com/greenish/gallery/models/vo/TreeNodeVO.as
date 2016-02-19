/**
 * Created by evgeny on 19.02.16.
 */
package com.greenish.gallery.models.vo {
import flash.display.Bitmap;

public class TreeNodeVO {

    private var _id:Number;
    private var _isHorizontal:Boolean;
    private var _totalWidth:Number;
    private var _totalHeight:Number;

    private var _left:TreeNodeVO;
    private var _right:TreeNodeVO;
    private var _parent:TreeNodeVO;
    private var _img:Bitmap;

    private var _x:Number;
    private var _y:Number;

    public function get isImage():Boolean {
        return _img!=null;
    }



    public function get isHorizontal():Boolean {
        return _isHorizontal;
    }

    public function set isHorizontal(value:Boolean):void {
        _isHorizontal = value;
    }


    public function get totalWidth():Number {
        return _totalWidth;
    }

    public function set totalWidth(value:Number):void {
        _totalWidth = value;
    }

    public function get totalHeight():Number {
        return _totalHeight;
    }

    public function set totalHeight(value:Number):void {
        _totalHeight = value;
    }

    public function get left():TreeNodeVO {
        return _left;
    }

    public function set left(value:TreeNodeVO):void {
        _left = value;
    }

    public function get right():TreeNodeVO {
        return _right;
    }

    public function set right(value:TreeNodeVO):void {
        _right = value;
    }

    public function get parent():TreeNodeVO {
        return _parent;
    }

    public function set parent(value:TreeNodeVO):void {
        _parent = value;
    }

    public function get img():Bitmap {
        return _img;
    }

    public function set img(value:Bitmap):void {
        _img = value;
    }


    public function get id():Number {
        return _id;
    }

    public function set id(value:Number):void {
        _id = value;
    }

    public function get x():Number {
        return _x;
    }

    public function set x(value:Number):void {
        _x = value;
    }

    public function get y():Number {
        return _y;
    }

    public function set y(value:Number):void {
        _y = value;
    }
}
}
