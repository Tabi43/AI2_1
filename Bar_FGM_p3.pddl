(define (problem bar-prob) 
        (:domain bar)
        
(:objects 
    ambrogio gertrude - waiter
    t1 t2 t3 t4 b A G - location
    d1 d2 d3 d4 - drink
)

(:init  
    ;---WAITERS---
    ;waiter init ambrogio
    (at_location A ambrogio)  
    (free ambrogio)
    (work_at ambrogio A) 
    (=(speed ambrogio) 2)  

    ;waiter init  gertrude
    (at_location G gertrude)
    (free gertrude)
    (work_at gertrude G)
    (=(speed gertrude) 2)


    ;---BAR---
    ;map location
    (=(distance_location b t1) 2) (=(distance_location t1 b) 2)
    (=(distance_location b t2) 2) (=(distance_location t2 b) 2)
    (=(distance_location b t3) 3) (=(distance_location t3 b) 3)
    (=(distance_location b t4) 3) (=(distance_location t4 b) 3)
    (=(distance_location t1 t2) 1)  (=(distance_location t1 t3) 1)  (=(distance_location t1 t4) 1)
    (=(distance_location t2 t1) 1)  (=(distance_location t2 t3) 1)  (=(distance_location t2 t4) 1)
    (=(distance_location t3 t1) 1)  (=(distance_location t3 t2) 1)  (=(distance_location t3 t4) 1)
    (=(distance_location t4 t1) 1)  (=(distance_location t4 t2) 1)  (=(distance_location t4 t3) 1)
    (=(distance_location A b) 0) (=(distance_location b A) 0)
    (=(distance_location A t1) 2) (=(distance_location A t2) 2) 
    (=(distance_location A t3) 3) (=(distance_location A t4) 3)
    (=(distance_location t1 A) 2) (=(distance_location t2 A) 2) 
    (=(distance_location t3 A) 3) (=(distance_location t4 A) 3)
    (=(distance_location G b) 0) (=(distance_location b G) 0)
    (=(distance_location G t1) 2) (=(distance_location G t2) 2) 
    (=(distance_location G t3) 3) (=(distance_location G t4) 3)    
    (=(distance_location t1 G) 2) (=(distance_location t2 G) 2) 
    (=(distance_location t3 G) 3) (=(distance_location t4 G) 3)
    
    (=(dim_table t1) 1)
    (=(dim_table t2) 1)
    (=(dim_table t3) 2)
    (=(dim_table t4) 1)

    ;initialize bar    
    (bar b)  
    (tray_at b)
    (=(number_drink_on_tray) 0)
    (= (biscuit_on_tray) 0)
    (= (time_2_drink d1) 0) (= (time_2_drink d2) 0) (= (time_2_drink d3) 0) (= (time_2_drink d4) 0) 
    (= (time_2_prep d1) 0) (= (time_2_prep d2) 0) (= (time_2_prep d3) 0) (= (time_2_prep d4) 0)

    ;problem specification
    (order d1) (order d2) (order d3) (order d4)
    (warm d1) (warm d2) (warm d3) (warm d4)
    (assigned ambrogio d3) (assigned ambrogio d4)
    (assigned gertrude d1) (assigned gertrude d2)
    (= (drinks_assigned t4) 2)
    (= (drinks_assigned t1) 2)
    (=(square_2_clean t3) 2)
    (=(square_2_clean t2) 0)
    (=(square_2_clean t1) 0)
    (=(square_2_clean t4) 0)
    ;table assignment

)

(:goal (and 
        (at_location t4 d1) (at_location t4 d2) (at_location t1 d3) (at_location t1 d4) 
        (warm d1) (warm d2) (warm d3) (warm d4)
        (= (drinks_assigned t4) 0)
        (= (drinks_assigned t1) 0)  
        (=(square_2_clean t4) 0)
        (=(square_2_clean t1) 0)
        (=(square_2_clean t3) 0)
        (not (busy gertrude)) (not (busy ambrogio)) 
        (at_location A ambrogio) (at_location G gertrude)    
    )
)

)
