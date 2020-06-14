#Defining current state of game
current_state = Any[[".",".","."],
                [".",".","."],
                [".",".","."]]

#X is the minimizing player
#O is the maximizing player

# Player X plays first
player_turn = "X"
result = nothing


#Draw a board of a 3 by 3 seperated by "|" 

#i == arrays
#j== index
function draw_board()
    global current_state = current_state
        for i in 1:3
            for j in 1:3
                print(current_state[i][j], "|")
            end
            println()
        end
        println()
end

# Checks if the game has ended and returns the winner in each case

    #[1][1] | [1][2] | [1][3]   => [1] first array for index 1
    #-------+--------+-------
    #[2][1] | [2][2] | [2][3]   => [2] second array for index 2
    #-------+--------+-------
    #-------+--------+-------
    #[3][1] | [3][2] | [3][3]   => [3] Third array for index 3
function is_end()
    global current_state = current_state
    
    # Vertical win
    #loops through verticaly and checks if it has the same value of of X or 0
   
    for i in 1:3
        if current_state[1][i] != "."
            if current_state[1][i] == current_state[2][i]
                if current_state[2][i] == current_state[3][i]
                    return current_state[1][i]
                end
            end
        end
    end

    # Horizontal win
    #loops through Horizontal and check if any array with any index has avalues of X only or 0 only 
    #and return win respectivly
    for i in 1:3
        if (current_state[i] == ["X", "X", "X"])
            return "X"
        elseif (current_state[i] == ["O", "O", "O"])
            return "O"
        end
    end

    # Main diagonal win
    # runs from top left to bottom right
    # 
    #   X   | [1][2] | [1][3]   
    #-------+--------+-------
    #[2][1] |   X    | [2][3]   
    #-------+--------+-------
    #-------+--------+-------
    #[3][1] | [3][2] |   X 
    
    if current_state[1][1] != "."
        if current_state[1][1] == current_state[2][2]
            if current_state[1][1] == current_state[3][3]
                return current_state[1][1]
            end
        end
    end

    # Second diagonal win
    #runs from lower left entry to the upper right entry
    #
    #[1][1] | [1][2] |   X   
    #-------+--------+-------
    #[2][1] |   X    | [2][3]   
    #-------+--------+-------
    #-------+--------+-------
    #   X   | [3][2] | [3][3]   
    
    if current_state[1][3] != "."
        if current_state[1][3] == current_state[2][2]
            if current_state[1][3] == current_state[3][1]
                return current_state[1][3]
            end
        end
    end

    # Check If whole board full
    for i in 1:3
        for j in 1:3
            # If There's an empty field, we continue the game
            #if there no empty field it returns a tie
            if current_state[i][j] == "."
                return nothing
            end
        end
    end

    # It's a tie!
    return "."
end

#Alpha: The best (highest-value) |  x-index
#Beta: The best (lowest-value) |y-index

#score = 1 if maximizing player ends up winning && minimizing loses
#score = -1 if maximizing player ends up losing && minimizing wins
#score = 0 if it is a tie

function max_alpha_beta(alpha, beta)
    global current_state = current_state
    maxv = -2 #intializae maxv |alpha (value should be greater than -2)
    px = nothing
    py = nothing

    result = is_end()

    if result == "X"  #X is the minimizing player
        return (-1, 0, 0)   #X wins, so the end flag is -1
        
    elseif result == "O" #O is the maximizing player
        return (1, 0, 0) # O wins, so the end flag is 1
    elseif result == "."  #tie
        return (0, 0, 0)  #there is a tie, so the end flag is 0
    end

    for i in 1:3
        for j in 1:3
            if current_state[i][j] == "." #the value cell need to be ".", so it is a possible move for the player
                current_state[i][j] = "O"
                infos = min_alpha_beta(alpha, beta) #infos = (minimum value, x-index, y-index)
                m = infos[1]  #infos[1] is the minimum value
                min_i = infos[2] #x-index
                in_j = infos[3] #y-index
                if m > maxv
                    maxv = m
                    px = i
                    py = j
                end
                current_state[i][j] = "."

                # Next two ifs in Max and Min are the only difference between regular algorithm and minimax
                if maxv >= beta #beta = 2
                    return (maxv, px, py)
                end

                if maxv > alpha #alpha = -2
                    alpha = maxv
                end
            end
        end
    end

    return (maxv, px, py) # returns (maximum value, x-index, y-index)
end

function min_alpha_beta(alpha, beta)
        global current_state = current_state
        minv = 2 #intializae minv |beta (value should be less than 2)
        qx = nothing
        qy = nothing

        result = is_end()

        if result == "X"
            return (-1, 0, 0)
        elseif result == "O"
            return (1, 0, 0)
        elseif result == "."
            return (0, 0, 0)
        end

        for i in 1:3
            for j in 1:3
                if current_state[i][j] == "."
                    current_state[i][j] = "X"
                    infos = max_alpha_beta(alpha, beta)
                    m = infos[1]      #infos[1] is the maximum value
                    max_i = infos[2]  # the x index
                    max_j = infos[3]  # the y index
                    if m < minv
                        minv = m
                        qx = i
                        qy = j
                    end
                    current_state[i][j] = "."

                    if minv <= alpha
                        return (minv, qx, qy)
                    end

                    if minv < beta
                        beta = minv
                    end
                end
            end
        end

        return (minv, qx, qy)
end

# Determines if the made move is a legal move
function is_valid(px, py)
    global current_state = current_state
    if px < 1 || px > 3|| py < 1 || py > 3
        return false
    elseif current_state[px][py] != "."
        return false
    else
        return true
    end
end


#function to play game
function play_alpha_beta()
    global result = result
    global player_turn = player_turn
    global current_state = current_state

    while true
        draw_board()
        result = is_end()

        if result != nothing
            if result == "X"
                println("The winner is X!")
            elseif result == "O"
                println("The winner is O!")
            elseif result == "."
                println("It's a tie!")
            end
            return
        end

        if player_turn == "X"
            while true
                infos = min_alpha_beta(-2, 2)
                m = infos[1]
                qx = infos[2]
                qy = infos[3]
                println("Recommended move: X = ", qx ,", Y = ", qy)

                print("Insert the X coordinate: ")
                px = parse(Int64, readline(stdin))
                print("\nInsert the Y coordinate: ")
                py = parse(Int64, readline(stdin))
                println()

                qx = px
                qy = py

                if is_valid(px, py)
                    current_state[px][py] = "X"
                    player_turn = "O"
                    break
                else
                    println("The move is not valid! Try again.")
                end
            end
        else
            infos = max_alpha_beta(-2, 2)
            m = infos[1]
            px = infos[2]
            py = infos[3]
            current_state[px][py] = "O"
            player_turn = "X"
        end
    end
end


play_alpha_beta()



