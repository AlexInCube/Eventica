// feather disable all

suite(function() { 
    describe("Eventica Global", function(){
        it("Handler Exists", function(){
            expect(EVENTICA_HANDLER).toBeEqual(new EventicaHandler())
        })
    })
    
    describe("EventicaHandler", function(){
        describe(".on()", function(){
            afterEach(function(){
                EVENTICA_HANDLER.removeAllListeners()
            })
        
            describe("Struct Listener", function(){
                it("Subscribe", function(){
                    var structListener = new EventicaMockStructListener()
                    
                    with (structListener){
                        EVENTICA_HANDLER.on(".on() hello struct", EventicaMockEmptyFunction)
                    }
                    
                    var event = EVENTICA_HANDLER.__events[$ ".on() hello struct"][0]
                    
                    expect(event).toHaveProperty("scope")
                    expect(event.scope.ref).toBeEqual(structListener)
                })    
            })
            
            describe("Instance Listener", function(){
                it("Subscribe", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)
                    
                    with (instanceListener){
                        EVENTICA_HANDLER.on(".on() hello instance", EventicaMockEmptyFunction)
                    }
                    
                    expect(EVENTICA_HANDLER.__events[$ ".on() hello instance"][0]).toHaveProperty("scope")
                    instance_destroy(instanceListener)
                })    
            })
        })
            
            
        describe(".emit()", function(){
            afterEach(function(){
                EVENTICA_HANDLER.removeAllListeners()
            })
            
            describe("Struct Listener", function(){
                it("Callback Executing", function(){
                    var structListener = new EventicaMockStructListener()
                    
                    with (structListener){
                        EVENTICA_HANDLER.on(".emit() hello struct", self.counterUp)
                    }
                    
                    EVENTICA_HANDLER.emit(".emit() hello struct")
                    
                    expect(structListener.counterGetValue()).toBeEqual(1)
                    
                    EVENTICA_HANDLER.removeAllListeners()
                })
                
               /// TODO: Wait GMTL v1.1 with timers simulation
                /*
                it("Auto-unsubscribe if listener is not exists", function(){
                    var structListener = new EventicaMockStructListener()
                    
                    with (structListener){
                        EVENTICA_HANDLER.on(".emit() hello struct", self.counterUp)
                    }
                    
                    structListener = {}
                    
                    //call_later(1, time_source_units_seconds, function(){
                        EVENTICA_HANDLER.emit(".emit() hello struct")
                    //})
                    
                    var event = EVENTICA_HANDLER.__events[$ ".emit() hello struct"]
                    
                    expect(event).toBe(undefined)
                })
                 */
            })
            
            describe("Instance Listener", function(){
                it("Callback executing", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)
                    
                    with (instanceListener){
                        EVENTICA_HANDLER.on(".emit() hello instance", self.counterUp)
                    }
                    
                    EVENTICA_HANDLER.emit(".emit() hello instance")
                    
                    expect(instanceListener.counterGetValue()).toBeEqual(1)
                    instance_destroy(instanceListener)
                })
                
                it("Auto-unsubscribe if listener is not exists", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)
                    
                    with (instanceListener){
                        EVENTICA_HANDLER.on(".emit() hello instance", self.counterUp)
                    }
                    
                    instance_destroy(instanceListener)
                    
                    EVENTICA_HANDLER.emit(".emit() hello instance")

                    expect(EVENTICA_HANDLER.__events[$ ".emit() hello instance"]).toBe(undefined)
                })
            })
        })
        
        describe(".off()", function(){
            afterEach(function(){
                EVENTICA_HANDLER.removeAllListeners()
            })
            
            describe("Struct Listener", function(){
                it("Unsubcribing", function(){
                    var structListener = new EventicaMockStructListener()
                    
                    with (structListener){
                        EVENTICA_HANDLER.on(".off() hello struct", self.counterUp)
                    }
                    
                    with (structListener){
                        EVENTICA_HANDLER.off(".off() hello struct")
                    }
                    
                    expect(EVENTICA_HANDLER.__events[$ ".off() hello struct"]).toBe(undefined)    
                })
            })
            
            describe("Instance Listener", function(){
                it("Unsubcribing", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)
                    
                    with (instanceListener){
                        EVENTICA_HANDLER.on(".off() hello instance", self.counterUp)
                    }
                    
                    with (instanceListener){
                        EVENTICA_HANDLER.off(".off() hello instance")
                    }
                    
                    expect(EVENTICA_HANDLER.__events[$ ".off() hello instance"]).toBe(undefined)   
                    instance_destroy(instanceListener)
                })
            })
        })
    })
});