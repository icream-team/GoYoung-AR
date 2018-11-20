using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//using System.diagnotics;

public class GoYoung : MonoBehaviour
{
    public SaveDataList SavedData;

    private double love;
    private double hungry;
    private System.DateTime EndTime;
    private float RunningTime;
    private double hungry_variation = 1;
    private double love_variation = 1;


    private float MotionTimeInterval = 5.0f;

    // getter & setter
    public void SetLove(int loveVariation)    // LOVE범위 설정
    {
        love = love + loveVariation;

        if (love < 0)
            love = 0;

        if (love > 100)
            love = 100;
    }
    public double GetLove()                    
    {
        return love;
    }
    public void SetHugry(int hungryVariation)  //hungry 범위 설정
    {
        hungry = hungry + hungryVariation;

        if (hungry < 0)
            hungry = 0;

        if (hungry > 100)
            hungry = 100;
    }
    public double GetHungry()
    {
        return hungry;
    }
    public System.DateTime GetTime()
    {
        return System.DateTime.Now;
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
        
        if(SavedData != null && SavedData.SavedDataList.Count >0) // 저장된 데이터 불러옴
        {
            EndTime = SavedData.SavedDataList[0].Time;     
            hungry = SavedData.SavedDataList[0].Status;
            love = SavedData.SavedDataList[0].Love;
        }

        double SpanTime = TimeCal();
        if(hungry - SpanTime/4 < 0)
        {
            hungry = 0;
        } // hungry 조정
        else
        {
            hungry = hungry - SpanTime / 4;
        }

        if (love - SpanTime / 5 < 0)
        {
            love = 0;
        } // love 조정
        else
        {
            love = love - SpanTime / 5;
        }


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
        RunningTime += Time.deltaTime;
        if (RunningTime >= 600)  //10분마다 하락
        {
            hungry -= 5 * hungry_variation;
            love -= 5 * love_variation;
            RunningTime = 0;
        }
        if(hungry<40)
        {
            hungry_variation = 1.5;
            love_variation = 1.5;
        }
        else if (hungry<30)
        {
            hungry_variation = 2.0;
            love_variation = 2.0;
        }
        else if(hungry <10)
        {
            hungry_variation = 3.0;
            love_variation = 3.0;
        }
	}

    void OnApplicationQuit()  // 끝날때 호출되는 함수
    {
        EndTime = System.DateTime.Now;
    }

    private double TimeCal()
    {
        //이전에 게임이 끝난 시간을 load해와서 둘이 계산.
        System.DateTime StartTime = System.DateTime.Now; // 년-월-일- 오전/오후 시:분:초 로 저장
        System.TimeSpan SpanTime = EndTime - StartTime;
        return SpanTime.TotalMinutes;
    }

}
