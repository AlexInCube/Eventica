suite(function() { 
    describe("Eventica Global", function(){
        it("Handler Exists", function(){
            expect(EVENTICA_HANDLER).toBeEqual(new EventicaHandler())
        })
    })
    
    describe("EventicaHandler", function(){
        beforeEach(function(){
            // Reset handler for each test
            EVENTICA_HANDLER.__events = {}
        })
        
        describe(".on", function(){
            it("Struct subscribe", function(){
                var structListener = new EventicaMockStructListener()
                
                with (structListener){
                    EVENTICA_HANDLER.on("hello struct")
                }
                
                expect(EVENTICA_HANDLER.__events[$ "hello struct"][0]).toHaveProperty("scope")
            })    
            
            it("Object subscribe", function(){
                var objectListener = create(0, 0, obj_eventica_mock)
                
                with (objectListener){
                    EVENTICA_HANDLER.on("hello object")
                }
                
                expect(EVENTICA_HANDLER.__events[$ "hello object"][0]).toHaveProperty("scope")
            })    
        })
    })
});