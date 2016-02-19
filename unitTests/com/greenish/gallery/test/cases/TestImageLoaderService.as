/**
 * Created by evgeny on 18.02.16.
 */
package com.greenish.gallery.test.cases {
import com.greenish.gallery.events.DataLoaderEvent;
import com.greenish.gallery.services.remote.ImageLoaderService;

import flash.events.EventDispatcher;

import org.flexunit.Assert;

import org.flexunit.async.Async;

public class TestImageLoaderService {

    private var _serviceDispatcher:EventDispatcher = new EventDispatcher();
    private var _service:ImageLoaderService;
    [Before]
    public function setUp():void
    {
        _serviceDispatcher = new EventDispatcher();
        _service = new ImageLoaderService();
        _service.eventDispatcher = _serviceDispatcher;
    }

    [After]
    public function tearDown():void
    {
        this._serviceDispatcher = null;
        this._service = null;
    }

    [Test(async)]
    public function testRetreiveImages():void
    {
        this._serviceDispatcher.addEventListener( DataLoaderEvent.DATA_COMPLETE,
                Async.asyncHandler(this, handleImagesReceived, 8000, null,
                        handleServiceTimeout), false, 0, true);
        this._service.load();
    }
    protected function handleServiceTimeout( object:Object ):void
    {
        Assert.fail('Pending Event Never Occurred');
    }

    protected function handleImagesReceived(event:DataLoaderEvent, object:Object):void
    {
        Assert.assertEquals("The gallery should have some photos: ",
                event.vo.items.length > 0, true)
    }
}
}
