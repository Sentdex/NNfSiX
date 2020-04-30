<#
Doing dot product with a layer of neurons and multiple inputs
#>

$inputs = (1, 2, 3, 2.5)
$weights = ((0.2, 0.8, -0.5, 1.0),(0.5, -0.91, 0.26, -0.5),(-0.26, -0.27, 0.17, 0.87))
$biases =  (2, 3, 0.5)


<#
Could not find standard libraries for calculating dot product and array addition.
Therefore below are the two required helper functions.
#>

function dotProduct 
{
    [CmdletBinding()]

    param ([array]$inputs,[array]$weights)

    # Iterate through list of list
    $output = @()
    foreach ($weight in $weights){
        $count = 0   # To use this as an index
        $partoutput = @()   # temporary list
        # Iterate through list
        foreach($weightElement in $weight){ 
          $partoutput = ($inputs[$count] * $weightElement)    
          $count += 1
        }
    # Sum the values in the $partoutput list and append to $output
    $output += ($partoutput -split ','  | measure-object -sum).sum
    }
    return $output
}

function sumArray
{
  [CmdletBinding()]
  param([array]$array1, [array]$array2)
  # Check if the array size matches
  if($array1.Length -eq $array2.Length){
    $count = 0
    $output = @()
    # Iterate through list
    foreach($item in $array1){
       $output += $item + $array2[$count]
       $count += 1
     }
     return $output
  }else{
  return "The size of two input arrays do not match."
  }
} 

# Calling the two helper functions
$layerOutputs = sumArray (dotProduct $inputs $weights) $biases 

Write-Host $layerOutputs