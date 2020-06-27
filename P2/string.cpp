#include<stdio.h>

char a[20];
int n;

int main()
{
	scanf("%d",&n);
	for (int i=0;i<n;i++)
	{
		char c;
		getchar();
		scanf("%c",&c);
		a[i]=c;
	}
	
	int ok=1;
	int i=0,j=n-1;
	while (i<n&&j>=0)
	{
		if (a[i]!=a[j])
			ok=0;
		i++;
		j--;
	}	
	printf("%d\n",ok);
	return 0;
}
