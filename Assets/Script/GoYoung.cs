using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GoYoung : MonoBehaviour
{
    private int love;
    private int hungry;

    private float MotionTimeInterval = 5.0f;

    // getter & setter
    public void SetLove(int loveVariation)
    {
        love = love + loveVariation;

        if (love < 0)
            love = 0;

        if (love > 100)
            love = 100;
    }
    public int GetLove()
    {
        return love;
    }
    public void SetHugry(int hungryVariation)
    {
        hungry = hungry + hungryVariation;

        if (hungry < 0)
            hungry = 0;

        if (hungry > 100)
            hungry = 100;
    }
    public int GetHungry()
    {
        return hungry;
    }

    private bool readCatInfo()
    {
        Debug.Log("readCatInfo");

        return false;
    }
    private void saveCatInfo()
    {
        Debug.Log("saveCatInfo");
    }
    private void resetCatInfo()
    {
        love = 40;
        hungry = 40;

        Debug.Log("resetCatInfo");
    }

    // Use this for initialization
    void Start ()
    {
        if (readCatInfo())
        {

        }
        else
        {
            resetCatInfo();
        }

        Invoke("SetMotion", MotionTimeInterval);
	}

    public void SetMotion()
    {
        Debug.Log("SetMotion");

        Invoke("SetMotion", MotionTimeInterval);
    }

    // Update is called once per frame
    void Update ()
    {
	}
}
