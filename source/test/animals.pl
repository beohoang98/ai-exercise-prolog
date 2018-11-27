animal(bird).
animal(duck).
animal(fish).
animal(dog).
animal(cat).
animal(human).
animal('Pikachu asd').

% test command
fly(bird).

swim(duck).
swim(fish).

eat(bird, apple).
eat(duck, fish).
eat(human, duck).
eat(human, fish).
eat(human, bird).
eat(dog, fish).
eat(cat, fish).

food(X):-
    eat(human, X).

seafood(X):-
    food(X),
    swim(X),
    animal(X).