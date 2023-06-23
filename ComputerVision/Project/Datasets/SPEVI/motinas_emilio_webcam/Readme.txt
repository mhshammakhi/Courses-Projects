Each line in the ground truth file describes the positions of the objects in a frame.

The syntax of a line is the following:

<Frame>	<Number of objects>		<Object name>	<X pos>	<Y pos>	<Half Width>	<Half Height>	<Angle>	<Object name>	<X pos>	<Y pos>	<Half Width>	<Half Height>	<Angle> etc......

Using C each line in the Ground truth File "gtFile" can be read using the code:


if(EOF !=fscanf(gtFile,"%d	%d		", &FrameNr, &nrTgts) )
{
	for(int i=0; i<nrTgts; i++)
		if(EOF !=fscanf(m_gtFile,"%s	%d	%d	%d	%d	%d	",&tgtName, &x, &y, &HfW, &HfH, &ang) )
}
		
