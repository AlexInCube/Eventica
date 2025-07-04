// feather disable all

// Comment "exit" if you want to run tests
//exit

suite(function() {
    describe("Eventica Global", function(){
        it("Handler Exists", function(){
            expect(instanceof(EVENTICA_HANDLER)).toBeEqual("EventicaHandler")
        })
    })

    describe("EventicaHandler", function(){
        describe(".on()", function(){
            afterEach(function(){
                EVENTICA_HANDLER.removeAllListeners()
            })

            describe("Struct Listener", function(){
               it("Subscribe using \"with\"", function(){
                    var structListener = new EventicaMockStructListener()

                    with (structListener){
                        EVENTICA_HANDLER.on("on() hello struct", EventicaMockEmptyFunction)
                    }

                    var event = EVENTICA_HANDLER.__events[$ "on() hello struct"][0]

                    expect(event).toHaveProperty("scope")
                    expect(event.scope.ref).toBeEqual(structListener)
                })
                
                it("Subscribe in Struct", function(){
                    var structListener = new EventicaMockStructListenerAndAutoSubscribe()

                    var event = EVENTICA_HANDLER.__events[$ "struct auto subscribe"][0]

                    expect(event).toHaveProperty("scope")
                    expect(event.scope.ref).toBeEqual(structListener)
                    expect(instanceof(event.scope.ref)).toBeEqual("EventicaMockStructListenerAndAutoSubscribe")
                })
                
                it("Subscribe Struct within instance", function(){
                    var instance = create(0, 0, obj_eventica_mock_store_struct_listener)

                    var event = EVENTICA_HANDLER.__events[$ "struct auto subscribe"][0]

                    expect(event).toHaveProperty("scope")
                    expect(event.scope.ref).toBeEqual(instance.structListener)
                    expect(instanceof(event.scope.ref)).toBeEqual("EventicaMockStructListenerAndAutoSubscribe")
                    instance_destroy(instance)
                })
            })

            describe("Instance Listener", function(){
                it("Subscribe", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.on("on() hello instance", EventicaMockEmptyFunction)
                    }

                    expect(EVENTICA_HANDLER.__events[$ "on() hello instance"][0]).toHaveProperty("scope")
                    instance_destroy(instanceListener)
                })
            })
        })

        describe(".emit()", function(){
            afterEach(function(){
                EVENTICA_HANDLER.removeAllListeners()
            })

            describe("Struct Listener", function(){
                it("Basic Callback Executing", function(){
                    var structListener = new EventicaMockStructListener()

                    with (structListener){
                        EVENTICA_HANDLER.on("emit() hello struct", self.counterUp)
                    }

                    EVENTICA_HANDLER.emit("emit() hello struct")

                    expect(structListener.counterGetValue()).toBeEqual(1)

                    EVENTICA_HANDLER.removeAllListeners()
                })
                
                it("Callback Executing With Parameters", function(){
                    var structListener = new EventicaMockStructListener()

                    with (structListener){
                        EVENTICA_HANDLER.on("emit() hello struct", self.counterUpBy)
                    }

                    EVENTICA_HANDLER.emit("emit() hello struct", 23)

                    expect(structListener.counterGetValue()).toBeEqual(23)

                    EVENTICA_HANDLER.removeAllListeners()
                })
                
                it("Subscribe in Struct", function(){
                    var structListener = new EventicaMockStructListenerAndAutoSubscribe()

                    EVENTICA_HANDLER.emit("struct auto subscribe")
                    expect(structListener.counterGetValue()).toBeEqual(1)
                })
                
                it("Subscribe Struct within instance", function(){
                    var instance = create(0, 0, obj_eventica_mock_store_struct_listener)

                    EVENTICA_HANDLER.emit("struct auto subscribe")
                    expect(instance.structListener.counterGetValue()).toBeEqual(1)
                    instance_destroy(instance)
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
                it("Callback Executing", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.on("emit() hello instance", self.counterUp)
                    }

                    EVENTICA_HANDLER.emit("emit() hello instance")

                    expect(instanceListener.counterGetValue()).toBeEqual(1)
                    instance_destroy(instanceListener)
                })
                
                it("Callback Executing With Parameters", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.on("emit() hello instance", self.counterUpBy)
                    }

                    EVENTICA_HANDLER.emit("emit() hello instance", 23)

                    expect(instanceListener.counterGetValue()).toBeEqual(23)
                    instance_destroy(instanceListener)
                })

                it("Auto-unsubscribe if listener is not exists", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.on("emit() hello instance", self.counterUp)
                    }

                    instance_destroy(instanceListener)

                    EVENTICA_HANDLER.emit("emit() hello instance")

                    expect(EVENTICA_HANDLER.__events[$ ".emit() hello instance"]).toBe(undefined)
                })
            })
        })

        describe(".once()", function(){
            afterEach(function(){
                EVENTICA_HANDLER.removeAllListeners()
            })

            describe("Struct Listener", function(){
                it("Callback Executing", function(){
                    var structListener = new EventicaMockStructListener()

                    with (structListener){
                        EVENTICA_HANDLER.once("once() hello struct", self.counterUp)
                    }

                    EVENTICA_HANDLER.emit("once() hello struct")

                    expect(structListener.counterGetValue()).toBeEqual(1)

                    EVENTICA_HANDLER.emit("once() hello struct")

                    expect(structListener.counterGetValue()).toBeEqual(1)
                    expect(EVENTICA_HANDLER.__events[$ "emit() hello struct"]).toBe(undefined)
                })
            })

            describe("Instance Listener", function(){
                it("Callback Executing", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.once("once() hello instance", self.counterUp)
                    }

                    EVENTICA_HANDLER.emit("once() hello instance")

                    expect(instanceListener.counterGetValue()).toBeEqual(1)

                    EVENTICA_HANDLER.emit("once() hello instance")

                    expect(EVENTICA_HANDLER.__events[$ "once() hello instance"]).toBe(undefined)
                    instance_destroy(instanceListener)
                })
            })
        })

        describe(".many()", function(){
            afterEach(function(){
                EVENTICA_HANDLER.removeAllListeners()
            })

            describe("Struct Listener", function(){
                it("Callback Executing", function(){
                    var structListener = new EventicaMockStructListener()

                    with (structListener){
                        EVENTICA_HANDLER.many("many() hello struct", self.counterUp, 3)
                    }

                    EVENTICA_HANDLER.emit("many() hello struct")
                    expect(structListener.counterGetValue()).toBeEqual(1)

                    EVENTICA_HANDLER.emit("many() hello struct")
                    expect(structListener.counterGetValue()).toBeEqual(2)

                    EVENTICA_HANDLER.emit("many() hello struct")
                    expect(structListener.counterGetValue()).toBeEqual(3)

                    expect(EVENTICA_HANDLER.__events[$ "emit() hello struct"]).toBe(undefined)
                })
            })

            describe("Instance Listener", function(){
                it("Callback Executing", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.many("many() hello instance", self.counterUp, 3)
                    }

                    EVENTICA_HANDLER.emit("many() hello instance")
                    expect(instanceListener.counterGetValue()).toBeEqual(1)

                    EVENTICA_HANDLER.emit("many() hello instance")
                    expect(instanceListener.counterGetValue()).toBeEqual(2)

                    EVENTICA_HANDLER.emit("many() hello instance")
                    expect(instanceListener.counterGetValue()).toBeEqual(3)

                    expect(EVENTICA_HANDLER.__events[$ "many() hello instance"]).toBe(undefined)
                    instance_destroy(instanceListener)
                })
            })
        })

        describe(".off()", function(){
            afterEach(function(){
                EVENTICA_HANDLER.removeAllListeners()
            })

            describe("Struct Listener", function(){
                it("Basic Unsubcribing", function(){
                    var structListener = new EventicaMockStructListener()

                    with (structListener){
                        EVENTICA_HANDLER.on("off() hello struct", self.counterUp)
                    }

                    with (structListener){
                        EVENTICA_HANDLER.off("off() hello struct")
                    }

                    expect(EVENTICA_HANDLER.__events[$ "off() hello struct"]).toBe(undefined)
                })
            })

            describe("Instance Listener", function(){
                it("Unsubcribing", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.on("off() hello instance", self.counterUp)
                    }

                    with (instanceListener){
                        EVENTICA_HANDLER.off("off() hello instance")
                    }

                    expect(EVENTICA_HANDLER.__events[$ "off() hello instance"]).toBe(undefined)
                    instance_destroy(instanceListener)
                })
            })
        })
        
        describe(".removeAllListeners()", function(){
            it("Remove all listeners from all events", function(){
                var structListener = new EventicaMockStructListener()

                with (structListener){
                    EVENTICA_HANDLER.on("removeAllListeners() hello struct", EventicaMockEmptyFunction)
                }

                EVENTICA_HANDLER.removeAllListeners()

                expect(struct_names_count(EVENTICA_HANDLER.__events)).toBe(0)
            })    
            
             it("Remove all listeners from certain event", function(){
                var structListener = new EventicaMockStructListener()

                with (structListener){
                    EVENTICA_HANDLER.on("removeAllListeners() hello struct 1", EventicaMockEmptyFunction)
                    EVENTICA_HANDLER.on("removeAllListeners() hello struct 2", EventicaMockEmptyFunction)
                }

                EVENTICA_HANDLER.removeAllListeners("removeAllListeners() hello struct 1")

                expect(struct_names_count(EVENTICA_HANDLER.__events)).toBe(1)
                expect(EVENTICA_HANDLER.__events[$ "removeAllListeners() hello struct 1"]).toBe(undefined)
                expect(EVENTICA_HANDLER.__events[$ "removeAllListeners() hello struct 2"]).never().toBe(undefined)
            })    
        })

        describe("Internal Events", function(){
            describe(__EVENTICA_EVENT_ADD_LISTENER, function(){
                beforeEach(function(){
                    EVENTICA_HANDLER.option_event_add_listener = true
                })
                
                afterEach(function(){
                    EVENTICA_HANDLER.removeAllListeners()
                })

                it("Instance Listener", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.on(__EVENTICA_EVENT_ADD_LISTENER, self.counterUp)
                        EVENTICA_HANDLER.on("test event addListener", self.counterUp)
                    }

                    EVENTICA_HANDLER.emit("test event addListener")
                    EVENTICA_HANDLER.emit("test event addListener")

                    expect(instanceListener.counterGetValue()).toBeEqual(4)
                    instance_destroy(instanceListener)
                })

                it("Struct Listener", function(){
                    var structListener = new EventicaMockStructListener()

                    with (structListener){
                        EVENTICA_HANDLER.on(__EVENTICA_EVENT_ADD_LISTENER, self.counterUp)
                        EVENTICA_HANDLER.on("test event addListener", self.counterUp)
                    }

                    EVENTICA_HANDLER.emit("test event addListener")
                    EVENTICA_HANDLER.emit("test event addListener")

                    expect(structListener.counterGetValue()).toBeEqual(4)
                })
            })

            describe(__EVENTICA_EVENT_REMOVE_LISTENER, function(){
                beforeEach(function(){
                    EVENTICA_HANDLER.option_event_remove_listener = true
                })
                
                afterEach(function(){
                    EVENTICA_HANDLER.removeAllListeners()
                })

                it("Instance Listener", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.on(__EVENTICA_EVENT_REMOVE_LISTENER, self.counterUp)
                        EVENTICA_HANDLER.on("test event removeListener", EventicaMockEmptyFunction)

                        EVENTICA_HANDLER.off("test event removeListener")
                    }

                    expect(instanceListener.counterGetValue()).toBeEqual(1)
                    instance_destroy(instanceListener)
                })

                it("Struct Listener", function(){
                    var structListener = new EventicaMockStructListener()

                    with (structListener){
                        EVENTICA_HANDLER.on(__EVENTICA_EVENT_REMOVE_LISTENER, self.counterUp)
                        EVENTICA_HANDLER.on("test event removeListener", EventicaMockEmptyFunction)

                        EVENTICA_HANDLER.off("test event removeListener")
                    }

                    expect(structListener.counterGetValue()).toBeEqual(1)
                })
            })

            describe(__EVENTICA_EVENT_ANY, function(){
                beforeEach(function(){
                    EVENTICA_HANDLER.option_event_any = true
                })
                
                afterEach(function(){
                    EVENTICA_HANDLER.removeAllListeners()
                })

                it("Instance Listener", function(){
                    var instanceListener = create(0, 0, obj_eventica_mock)

                    with (instanceListener){
                        EVENTICA_HANDLER.on(__EVENTICA_EVENT_ANY, self.counterUp)
                        EVENTICA_HANDLER.on("test event any", self.counterUp)
                    }

                    EVENTICA_HANDLER.emit("test event any")

                    expect(instanceListener.counterGetValue()).toBeEqual(2)
                    instance_destroy(instanceListener)
                })

                it("Struct Listener", function(){
                    var structListener = new EventicaMockStructListener()

                    with (structListener){
                        EVENTICA_HANDLER.on(__EVENTICA_EVENT_ANY, self.counterUp)
                        EVENTICA_HANDLER.on("test event any", self.counterUp)
                    }

                    EVENTICA_HANDLER.emit("test event any")

                    expect(structListener.counterGetValue()).toBeEqual(2)
                })
            })
        })

        // TODO: Figure out how to test exceptions
        /*
        describe("Max Listeners", function(){
            it("Listeners", function(){
                var count = 1

                repeat (11) {
                	var structListener = new EventicaMockStructListener()
                    EVENTICA_HANDLER.on("test event any", EventicaMockEmptyFunction)
                }

                expect(count).toBeEqual(1)

                EVENTICA_HANDLER.removeAllListeners()
            })
        })
         */
    })
});
