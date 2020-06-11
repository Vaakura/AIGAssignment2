print("How items are available to choose from? ")
available_items = parse(Int64, readline(stdin))


itemNames = []
itemWeight = []
itemValue = []
for itemNum in 1:available_items
    print("Enter the name of the item: ")
    newItemName = readline(stdin)
    push!(itemNames, newItemName)
    print("Enter the weight of the item: ")
    newItemWeight = parse(Int64, readline(stdin))
    push!(itemWeight, newItemWeight)
    print("Enter the value of the item: ")
    newItemValue = parse(Int64, readline(stdin))
    push!(itemValue, newItemValue)
end

print("How much weight can the knapsack hold (no units)? ")
capacity = parse(Int64, readline(stdin))

#function to compare the weights of the items
function compWeight(item1, item2)
    if itemWeight[item1] > itemWeight[item2]
        return item2
    elseif itemWeight[item2] > itemWeight[item1]
        return item1
    else
        compValues(item1, item2)
    end
end

#function to compare the values of the items
#only run if the wieghts of the items are the same
function compValues(item1, item2)
    if itemValue[item1] > itemValue[item2]
        return item1
    elseif itemValue[item2] > itemValue[item1]
        return item2
    else
        return item1
    end
end

#function to check if item fits in the knapsack
fits = false
function itemFits(currentWt, itemWt)
    if (currentWt + itemWt) > capacity
        return false
    else
        return true
    end
end

bagged = 0 #number of items in the knapsack
iterations = 0 #how many times the loop has been repeated
lowWt = 1 #index of the lowest weight item
next = 1 #index of the next item in the list
currentWt = 0 #keep track of weight in bag

carryingName = []
carryingWeight = []
carryingValue = []

item = 1;
while(iterations == bagged)
    #choose the lowest weight item
    for item in 1:(available_items - 1)
        next = item + 1
        lowWt = compWeight(lowWt, next)
    end
    #make sure the item fits into the knapsack
    if(itemFits(currentWt, itemWeight[lowWt]))
        #if it does, we add the item to the knapsack
        push!(carryingName, itemNames[item])
        push!(carryingWeight, itemWeight[item])
        push!(carryingValue, itemValue[item])
        #and increase the weight accordingly
        currentWt = currentWt + itemWeight[item]
        #remove the added item from the available items
        available_items = available_items - 1
        #and increase the number of items that are in the knapsack
        bagged = bagged + 1
    end
    #whether or not the item fits, we will remove the item from the available item arrays
    splice!(itemNames, item)
    splice!(itemWeight, item)
    splice!(itemValue, item)
    #increase the number of iterations
    iterations = iterations + 1
    #if there are more iterations than there are items in the bag, then we stop the loop
    #otherwise, we continue until no more can fit into the knapsack
end

#print all the results below
bringItems = [carryingName, carryingWeight, carryingValue]
print("The items in the knapsack are:\n$bringItems")

currentWt = 0
i = 1
for i in carryingWeight
    currentWt = currentWt + i
end
print("\nThe weight of the knapsack is $currentWt")

totalValue = 0
for n in carryingValue
    totalValue = totalValue + n
end
print("\nThe total value of the knapsack is $totalValue")


print("How items are available to choose from? ")
available_items = parse(Int64, readline(stdin))

itemNames = []
itemWeight = []
itemValue = []
for itemNum in 1:available_items
    print("Enter the name of the item: ")
    newItemName = readline(stdin)
    push!(itemNames, newItemName)
    print("Enter the weight of the item: ")
    newItemWeight = parse(Int64, readline(stdin))
    push!(itemWeight, newItemWeight)
    print("Enter the value of the item: ")
    newItemValue = parse(Int64, readline(stdin))
    push!(itemValue, newItemValue)
end 

print("How much weight can the knapsack hold (no units)? ")
capacity = parse(Int64, readline(stdin))

function compWeight(item1, item2)
    if itemWeight[item1] > itemWeight[item2]
        return item2
    elseif itemWeight[item2] > itemWeight[item1]
        return item1
    else
        compValues(item1, item2)
    end
end

function compValues(item1, item2)
    if itemValue[item1] > itemValue[item2]
        return item1
    elseif itemValue[item2] > itemValue[item1]
        return item2
    else
        return item1
    end
end

fits = false

function itemFits(currentWt, itemWt)
    if (currentWt + itemWt) > capacity
        return false
    else
        return true
    end
end

bagged = 0

iterations = 0

lowWt = 1

next = 1

currentWt = 0

carryingName = []
carryingWeight = []
carryingValue = []

item = 1;
while(iterations == bagged)
    for item in 1:(available_items - 1)
        next = item + 1
        lowWt = compWeight(lowWt, next)
    end
    if(itemFits(currentWt, itemWeight[lowWt]))
        push!(carryingName, itemNames[item])
        push!(carryingWeight, itemWeight[item])
        push!(carryingValue, itemValue[item])
        currentWt = currentWt + itemWeight[item]
        available_items = available_items - 1
        bagged = bagged + 1
    end
    splice!(itemNames, item)
    splice!(itemWeight, item)
    splice!(itemValue, item)
    iterations = iterations + 1
end

bringItems = [carryingName, carryingWeight, carryingValue]
print("The items in the knapsack are:\n$bringItems")

currentWt = 0
i = 1
for i in carryingWeight
    currentWt = currentWt + i
end
print("\nThe weight of the knapsack is $currentWt")

totalValue = 0
for n in carryingValue
    totalValue = totalValue + n
end
print("\nThe total value of the knapsack is $totalValue")





