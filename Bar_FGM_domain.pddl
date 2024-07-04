(define (domain bar)

    (:requirements :strips :adl :typing :fluents :time)
  
    ;types
    (:types
        waiter location drink
    )
    
    ;predicates
    (:predicates
        ;location
        (at_location ?l - location ?x)
        (bar ?l - location)
        ;waiter
        (free ?w - waiter)        
        (on_robot ?w - waiter ?d - drink)
        (busy ?w - waiter)
        (going_to ?w - waiter ?l - location)
        (work_at ?w - waiter ?l - location)        
        ;drink
        (busy_shake)
        (warm ?d - drink)
        (order ?d - drink)
        (prepared ?d - drink)
        ;tray 
        (on_tray ?d - drink)
        (tray_at ?x)
        ;extra 1   
        (is_cooling ?d - drink)
        ;extra 2
        (assigned ?w - waiter ?d - drink)
        (loc_used ?l - location)
        ;extra 3
        (served ?d - drink)
        (dirty ?l - location)
        ;extra 4
        (need_biscuit ?d - drink)
        (biscuit_on_robot ?w - waiter)
        (give_biscuit ?d - drink)
    )

    ;functions
    (:functions
        (speed ?w - waiter)
        (distance ?w - waiter ?l - location)
        (distance_location ?l1 ?l2 - location)
        (number_drink_on_tray)
        (square_2_clean ?l - location)
        (time_2_prep ?d - drink)
        ;extra 1
        (time_2_cool ?d - drink)
        ;extra 3 
        (time_2_drink ?d - drink)
        (drinks_assigned ?l - location)
        (dim_table ?l - location)
        ;extra 4
        (biscuit_on_tray)
    )  

    ;actions - events - processes 
    (:action put_on_tray
        :parameters (?w - waiter ?l - location ?d - drink)
        :precondition (and (free ?w) (at_location ?l ?w) (tray_at ?l) (at_location ?l ?d) (assigned ?w ?d) (bar ?l) (< (number_drink_on_tray) 3))
        :effect (and
            (on_tray ?d)
            (not(at_location ?l ?d))
            (increase (number_drink_on_tray) 1)
            (work_at ?w ?l)             
        )
    ) 

    (:action take_drink
        :parameters (?w - waiter ?l - location ?d - drink)
        :precondition (and (at_location ?l ?w) (at_location ?l ?d) (free ?w) (bar ?l) (assigned ?w ?d))
        :effect (and
            (not (free ?w))
            (not (at_location ?l ?d))
            (on_robot ?w ?d)    
            (work_at ?w ?l)
        )
    )

    (:action take_biscuit_for
        :parameters (?d - drink ?w - waiter ?l - location)
        :precondition (and (free ?w) (at_location ?l ?w) (bar ?l) (need_biscuit ?d) (assigned ?w ?d))
        :effect (and 
            (not (free ?w))
            (biscuit_on_robot ?w)
            (work_at ?w ?l)
            (not (need_biscuit ?d))
            (give_biscuit ?d)
        )
    )

    (:action give_biscuit_to
        :parameters (?d - drink ?w - waiter ?l - location)
        :precondition (and (at_location ?l ?w) (not (bar ?l)) (at_location ?l ?d) (biscuit_on_robot ?w) (assigned ?w ?d) (give_biscuit ?d))
        :effect (and 
            (not (biscuit_on_robot ?w))
            (not (give_biscuit ?d))
            (free ?w)
            (work_at ?w ?l)
        )
    ) 

    (:action put_biscuit_on_tray
        :parameters (?d - drink ?w - waiter ?l - location)
        :precondition (and (free ?w) (at_location ?l ?w) (bar ?l) (need_biscuit ?d) (tray_at ?l) (< (biscuit_on_tray) 3) (assigned ?w ?d))
        :effect (and 
            (work_at ?w ?l)
            (increase (biscuit_on_tray) 1)
            (not (need_biscuit ?d))
            (give_biscuit ?d)
        )
    )
    
    (:action give_buiscuit_t
        :parameters (?d - drink ?w - waiter ?l - location)
        :precondition (and (at_location ?l ?w) (not (bar ?l)) (at_location ?l ?d) (tray_at ?w) (> (biscuit_on_tray) 0) (assigned ?w ?d) (give_biscuit ?d))
        :effect (and 
            (work_at ?w ?l)
            (decrease (biscuit_on_tray) 1)
            (not (give_biscuit ?d))
        )
    )
    

    (:action serve_drink_t
        :parameters (?w - waiter ?l - location ?d - drink)
        :precondition (and (at_location ?l ?w) (tray_at ?w) (on_tray ?d) (not (bar ?l)) (assigned ?w ?d))
        :effect (and
            (not (on_tray ?d))
            (at_location ?l ?d)            
            (work_at ?w ?l)
            (decrease (number_drink_on_tray) 1)
            (when (warm ?d) (not (is_cooling ?d)))
            (served ?d)
            (assign (time_2_drink ?d) 4)
            (when (not (warm ?d)) (need_biscuit ?d))
        )
    )
    
    (:action serve_drink_g
        :parameters (?w - waiter ?l - location ?d - drink)
        :precondition (and (at_location ?l ?w) (on_robot ?w ?d) (not (bar ?l)) (assigned ?w ?d))
        :effect (and
            (not (on_robot ?w ?d))
            (at_location ?l ?d)
            (free ?w)
            (work_at ?w ?l)
            (when (warm ?d) (not (is_cooling ?d)))
            (served ?d)
            (assign (time_2_drink ?d) 4)
            (when (not (warm ?d)) (need_biscuit ?d))
        )
    ) 

    (:action leave_tray
        :parameters (?w - waiter ?l - location)
        :precondition (and (at_location ?l ?w) (tray_at ?w) (bar ?l) (or (= (number_drink_on_tray) 0) (= (biscuit_on_tray) 0)))
        :effect (and
            (tray_at ?l)
            (free ?w)
            (not (tray_at ?w))
            (assign (speed ?w) 2)
            (work_at ?w ?l)
        )
    )

    (:action take_tray
        :parameters (?w - waiter ?l - location)
        :precondition (and (free ?w) (at_location ?l ?w) (tray_at ?l) (bar ?l) (or (> (number_drink_on_tray) 0) (> (biscuit_on_tray) 0)))
        :effect (and
            (not (tray_at ?l))
            (not (free ?w))
            (tray_at ?w)
            (assign (speed ?w) 1)
            (work_at ?w ?l)
        )
    )   
    
    (:action start_clean
        :parameters (?w - waiter ?l - location)
        :precondition (and (not (busy ?w)) (free ?w) (at_location ?l ?w) (>(square_2_clean ?l) 0))
        :effect (and
            (busy ?w)
            (not (work_at ?w ?l))
        )
    )

    (:event stop_clean
        :parameters (?w - waiter ?l - location)
        :precondition (and (busy ?w) (at_location ?l ?w) (free ?w) (<= (square_2_clean ?l) 0))
        :effect (and 
            (not (busy ?w))
            (work_at ?w ?l)
        )
    )
    
    (:action start_move
        :parameters (?w - waiter ?from ?to - location)
        :precondition (and (at_location ?from ?w) (work_at ?w ?from) (not (loc_used ?to)))
        :effect (and
            (not(at_location ?from ?w))
            (assign (distance ?w ?to) (distance_location ?from ?to))
            (going_to ?w ?to)
            (not (work_at ?w ?from))  
            (not (loc_used ?from))  
            (loc_used ?to)    
        )
    )

    (:event stop_move
        :parameters (?w - waiter ?to - location )
        :precondition (and (<=(distance ?w ?to) 0) (going_to ?w ?to))
        :effect (and
            (at_location ?to ?w) 
            (not (going_to ?w ?to))  
        )
    )
     
    (:process move
        :parameters (?w - waiter ?l - location)
        :precondition (and (going_to ?w ?l) (>(distance ?w ?l) 0))
        :effect (and
            (decrease (distance ?w ?l) (* #t (speed ?w)))            
        )
    )

    (:process clean
        :parameters (?w - waiter ?l - location)
        :precondition (and (busy ?w) (>(square_2_clean ?l) 0) (at_location ?l ?w))
        :effect (and
            (decrease (square_2_clean ?l) (* #t 0.5))
        )
    )

    (:process drinking
        :parameters (?d - drink)
        :precondition (and
            (served ?d)
            (> (time_2_drink ?d) 0)         
            (not (need_biscuit ?d))
            (not (give_biscuit ?d))  
        )
        :effect (and
            (decrease (time_2_drink ?d) (* #t 1.0))
        )
    )

    (:event end_drinking
        :parameters (?d - drink ?l - location)
        :precondition (and
            (served ?d)
            (<= (time_2_drink ?d) 0)
            (at_location ?l ?d)
        )
        :effect (and
            (not (served ?d))
            (decrease (drinks_assigned ?l) 1)
            (dirty ?l)
        )
    )

    (:event table_dirty
        :parameters (?l - location)
        :precondition (and
            (<= (drinks_assigned ?l) 0)
            (not (bar ?l))
            (dirty ?l)            
        )
        :effect (and
            (assign (square_2_clean ?l) (dim_table ?l))
            (not (dirty ?l))
        )
    )

    (:process cooling
        :parameters (?d - drink)
        :precondition (and
            (> (time_2_cool ?d) 0)
            (is_cooling ?d)
        )
        :effect (and
            (decrease (time_2_cool ?d) (* #t 1.0))
        )
    )    

    (:event drink_cold
        :parameters (?d - drink)
        :precondition (and
            (<= (time_2_cool ?d) 0)
            (is_cooling ?d)
        )
        :effect (and
            (not (warm ?d))
            (not (is_cooling ?d))
        )
    )    

    ;Barman Section
    (:action shake_it
        :parameters (?d - drink )
        :precondition (and (order ?d) (not (busy_shake)))
        :effect (and
            (not (order ?d))
            (prepared ?d)
            (busy_shake)
            (when (warm ?d) (assign (time_2_prep ?d) 5))
            (when (not(warm ?d)) (assign (time_2_prep ?d) 3))
        )
    )

    (:event pour_it
        :parameters (?d - drink ?l - location )
        :precondition (and (bar ?l) (<=(time_2_prep ?d) 0) (prepared ?d) (busy_shake))
        :effect (and 
            (at_location ?l ?d)
            (not (prepared ?d))
            (not (busy_shake))
            (when (warm ?d) (and (assign (time_2_cool ?d) 4) (is_cooling ?d)))           
        )
    )
    
    (:process prepare_drink
        :parameters (?d - drink)
        :precondition (and
            (>(time_2_prep ?d) 0)
            (busy_shake)
        )
        :effect (and
            (decrease (time_2_prep ?d) (* #t 1.0))
        )
    )
    
)
