;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 20230608_Tank) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Tank
;; program delivers a tank and its movements needed in the game of space invaders 

;; =================
;; Constants:

(define WIDTH  300)
(define HEIGHT 500)
(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define TANK-SPEED 2)

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))



;; TANK STRUCT
(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))


;; =================
;; Functions:

;; Tank -> Tank
;; start the world with (main 0)
;; program displays the shape of a tank that can move left and right on the screen
;; 
(define (main tank)
  (big-bang tank                         ; tank

;;          Tank
            (on-tick   next-tank)     ; Tank -> Tank
            (to-draw   render-tank)   ; Tank -> Image
            (on-key    move-tank)))   ; Tank KeyEvent -> Tank


;; Tank -> Tank
;; produce the next tank on each clock tick
(check-expect (next-tank T0                  ) (make-tank (+ (/ WIDTH 2) TANK-SPEED) 1))       ; tank middle of screen

(check-expect (next-tank (make-tank (0     -1)) (make-tank             0             -1))       ; tank travelling left at left screen edge [ie tank doesn't leave screen]
(check-expect (next-tank (make-tank WIDTH  1)) (make-tank             WIDTH          1))       ; tank travelling right at right screen edge [ie tank doesn't leave screen]

;; test when tank is just before the edge
(check-expect (make-tank (- WIDTH 2) 1) (make-tank (+ (- WIDTH 2) TANK-SPEED) 1))
(check-expect (make-tank          2 -1) (make-tank 0                         -1))

; (define (next-tank t) t)  ; stub

;; <template taken from tank>

(define (next-tank t)
  (cond [(< (+ (tank-x t) (* (tank-dir t) TANK-SPEED)) 0)     (make-tank 0     (tank-dir t))]   
        [(> (+ (tank-x t) (* (tank-dir t) TANK-SPEED)) WIDTH) (make-tank WIDTH (tank-dir t))]
        [else
         (make-tank (tank-x t) (tank-dir t))]))
       










;; Tank -> Image
;; render game as an image of a tank set against the background scene
;; !!!
(define (render-tank t) ...)


;; Tank KeyEvent -> Tank
;; move





;; Tank KeyEvent -> Tank
;; moves the tank left or right when an arrow key is pressed
;; !!!

(define (move-tank t) ...)































