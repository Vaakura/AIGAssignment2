#Author: Jason
#Date: 03-06-2020
#Descr: Knapsack problem solution suing hill-climbing concept written in julia

#Weight/Value
basicArray = []
#Ask for user input
numberOfItems = 0
print("\nHow many items would you like to include ?  --> ")
input = readline(stdin)
numberOfItems = parse(Int64, input)
println()
println()
#Ask for weight and values for each item
for i in 1:numberOfItems
	append!(basicArray, i)
end
#Fill array
for i in 1:numberOfItems
	#Ask for weight and value for each item
	print("Enter the weight of item ", i, " --> ")
	tmpWeight = parse(Int64, readline(stdin))
	println()
	print("Enter the value of item ", i, " --> ")
	tmpValue = parse(Int64, readline(stdin))
	#--
	tmpPoint = [tmpWeight, tmpValue]
	basicArray[i] = tmpPoint
	println("===========")
end

#Ask for the max weight
print("\nWhat is the maximum weight ?  --> ")
_MAX_WEIGHT = parse(Int64, readline(stdin))
if _MAX_WEIGHT==0
	_MAX_WEIGHT = 150	#Default weight
end


collection = basicArray

currentStateArray = Int[]
println()

function get_maxValue(state)
	tmpVals = []
	tmpPoint = 0
	maxVal = 0
	for lists in state
		append!(tmpVals, lists[2])
	end
	#---Get the corresponding point
	for lists in state
		if lists[2]==maximum(tmpVals)
			tmpPoint = lists
		end
	end

	return [maximum(tmpVals), tmpPoint]
end


function get_totalValue(state)
	if size(state)[1]>0
		state = state[1]
		regulator = 1	#Even for values
		total = 0
		for el in state
			if regulator%2==0
				total+=el
			end
			regulator+=1
		end
		return total
	end
end


function get_totalWeight(state)
	if size(state)[1]>0
		state = state[1]
		regulator = 2	#Even for values
		total = 0
		for el in state
			if regulator%2==0
				total+=el
			end
			regulator+=1
		end
		return total
	end
end


function evaluate(currentState, imutableState, _max_weight_)
	if size(currentState)[1]==0	#At the start
		#Get max value from imutable state
		getInfos = get_maxValue(imutableState)
		#Check if the weight is right
		if getInfos[2][1] > _max_weight_
			#Remove from imutable state
			filter!(e->e!=getInfos[2], imutableState)
			#Return current state and imutable state
			return [currentState, imutableState]
		else 	#Good weight
			#Remove from imutable state
			filter!(e->e!=getInfos[2], imutableState)
			#Update the current state
			append!(currentState, getInfos[2])
			#Return current state and imutable state
			return [currentState, imutableState]
		end
	else
		#Get next max item from imutable state
		getInfos = get_maxValue(imutableState)
		#Get total weight so far (current)
		_currentWeight = get_totalWeight(currentState)
		if (_currentWeight + getInfos[2][1]) > _max_weight_
			#Remove next max from imutable state
			filter!(e->e!=getInfos[2], imutableState)
			#Return current state without modification
			return [currentState[1], imutableState]
		else
			#Add to current state and remove from imutable state
			append!(currentState[1], getInfos[2])
			filter!(e->e!=getInfos[2], imutableState)
			#Return updated balues
			return [currentState[1], imutableState]
		end
	end
end




println("Initial set: ", collection)
println("\nMAX WEIGHT: ", _MAX_WEIGHT)
println("")


index = 0
while true
	global collection = collection
	global currentStateArray = currentStateArray
	global _MAX_WEIGHT = _MAX_WEIGHT
	if size(collection)[1]==0
		break
	end

	getIncrement = evaluate(currentStateArray, collection, _MAX_WEIGHT)
	currentStateArray = [getIncrement[1]]
	collection = getIncrement[2]
	println("[", index ,"] Current best score: ", get_totalValue(currentStateArray), " | weight: ", get_totalWeight(currentStateArray), " | set: ", currentStateArray)
	println()

	global index+=1
end
