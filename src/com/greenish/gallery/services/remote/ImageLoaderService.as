/**
 * Created by evgeny on 18.02.16.
 */
package com.greenish.gallery.services.remote {
import com.greenish.gallery.events.DataLoaderEvent;
import com.greenish.gallery.interfaces.ILoaderService;
import com.greenish.gallery.models.vo.SmartGalleryVO;
import flash.display.Bitmap;
import flash.display.Loader;
import flash.errors.IOError;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import org.robotlegs.mvcs.Actor;

/**
 * Loader service. Loads main XML, parses it, loads new photos and sends event with them
 */

public class ImageLoaderService extends Actor implements ILoaderService{
    //that is the max count of the pictures on the screen
    public static const MAX_PHOTOS_COUNT:int=21;

    //holds all images paths for load
    private var _data:Vector.<String> = new <String>[];
    //holds all bitmaps that were loaded
    private var _photos:Vector.<Bitmap>;

    private var _nowElementId:int=0;
    private var _photoCounter:int;
    private var _replaceId:int=-1;

    public function ImageLoaderService() {
        super();
    }

    /**
     * Method for loading main XML with pics list
     */
    public function load():void {
        var ldr:URLLoader= new URLLoader();
        ldr.addEventListener(Event.COMPLETE, onXMLLoaded);
        ldr.addEventListener(IOErrorEvent.IO_ERROR, onXMLError);
        ldr.load(new URLRequest("gallery.xml"));
    }

    /**
     * Method start to load 1 more picture and replace it with old one that were clicked
     * @param id - id of the image that should be replaced
     */
    public function replacePhoto(id:int):void {
        _replaceId = id;
        loadPictures(1);
    }

    /**
     * When XML were loaded we parse it and start loading first photos using MAX_PHOTOS_COUNT
     * @param event
     */
    private function onXMLLoaded(event:Event):void {
        event.target.removeEventListener(Event.COMPLETE, onXMLLoaded);
        event.target.removeEventListener(IOErrorEvent.IO_ERROR, onXMLError);
        var d:XML = new XML(event.target.data);
        d.children().(_data.push("images/"+@name+".jpg"));
        //now we should load first items
        loadPictures(MAX_PHOTOS_COUNT);
    }

    /**
     * Loads some pictures from array. If we reach the end of the array, we go to beginning
     * @param count - count of the images that should be loaded
     */
    private function loadPictures(count:int):void {
        _photos = new Vector.<Bitmap>();
        _photoCounter=count;
        while (count>0) {
            var ldr:Loader = new Loader();
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onPhotoLoaded);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onPhotoError);
            ldr.load(new URLRequest(_data[_nowElementId]));
            if (_nowElementId+1==_data.length) {
                _nowElementId=0;
            } else {
                _nowElementId+=1;
            }
            count-=1;
        }
    }


    /**
     * When one picture were loaded
     * @param event
     */
    private function onPhotoLoaded(event:Event):void {
        event.target.removeEventListener(Event.COMPLETE, onPhotoLoaded);
        event.target.removeEventListener(IOErrorEvent.IO_ERROR, onPhotoError);
        _photoCounter-=1;
        const bmp:Bitmap = event.target.content as Bitmap;
        bmp.smoothing=true;
        //add bitmap in vector
        _photos.push(bmp);
        //if it's the end of the loading, we should send it via dispatch
        if (_photoCounter==0) {
            var vo:SmartGalleryVO = new SmartGalleryVO();
            vo.replaceId=_replaceId;
            vo.items = _photos;
            dispatch(new DataLoaderEvent(DataLoaderEvent.DATA_COMPLETE,vo));

            //resetting var
            _replaceId=-1
        }
    }

    /**
     * Errors
     * @param event
     */
    private function onXMLError(event:IOErrorEvent):void {
        throw new Error("Couldn't load XML");
    }
    private function onPhotoError(event:IOErrorEvent):void {
        throw new Error("Couldn't load picture");
    }
}
}
