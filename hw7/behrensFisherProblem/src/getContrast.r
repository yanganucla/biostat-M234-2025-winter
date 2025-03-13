
getContrast <- function (index, numberGroups) {
	contrast <- replace(rep(0, times=numberGroups), index, c(1,-1))
	return(contrast)
}
